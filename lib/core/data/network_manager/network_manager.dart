import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:winit_agent/core/constants/api_routes.dart';
import 'package:winit_agent/core/utilities/extensions/num_extension.dart';

import '../../../locator.dart';
import '../../constants/app_config.dart';
import '../../constants/env/env.dart';
import '../../constants/named_routes.dart';
import '../../utilities/secure_storage/secure_storage_utils.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../services/navigation_service.dart';
import '../services/remote_config_service.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Platform': 'mobile'
    },
  );

  late final Dio client;
  // Variables to manage concurrent 401 token refresh synchronization
  bool _isRefreshing = false;
  Completer<String?>? _refreshTokenCompleter;

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal() {
    client = Dio(options);
    client.interceptors.clear();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool useAuth = options.extra["useAuth"] ?? true;
          if (useAuth) {
            String? token = await SecureStorageUtils.retrieveToken();
            print('token:::$token>>>');
            if (token != null && token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer $token";
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // Intercept 401 Unauthorized status codes
          if (error.response?.statusCode == 401) {

            final useAuth = error.requestOptions.extra['useAuth'] ?? true;

            if (useAuth) {

              String? newAccessToken, newRefreshToken;

              // --- CONCURRENT REQUEST LOCK ---
              if (!_isRefreshing) {
                // This is the first request to encounter the 401 error. Lock the thread door.
                _isRefreshing = true;
                _refreshTokenCompleter = Completer<String?>();
                try {

                  log("🔄 First 401 encountered. Initiating single refresh network call...");

                  // Use an isolated Dio instance to prevent infinite recursive interception loops
                  Dio refreshClient = Dio(BaseOptions(
                    baseUrl: AppConfig.baseUrl,
                    //validateStatus: (status) => status != null && status < 500,
                  ));

                  // 1. Retrieve refresh token from secure storage
                  String? refreshToken = await SecureStorageUtils.retrieveRefreshToken();

                  if (refreshToken == null) throw Exception("No refresh token stored to refresh.");

                  // 2. Fire the refresh call passing the token directly inside the Authorization header
                  var response = await refreshClient.post(
                    ApiRoutes.refreshToken,
                    options: Options(
                      headers: {
                        HttpHeaders.acceptHeader: 'application/json',
                        HttpHeaders.contentTypeHeader: 'application/json',
                        "Authorization": "Bearer $refreshToken",
                        'Platform': 'mobile'
                      },
                    ),
                  );

                  log('full response::::::${response.data}>>>>');

                  // 3. Extract the new token from your backend's specific JSON response footprint
                  newAccessToken = response.data['data']['access_token'];
                  newRefreshToken = response.data['data']['refresh_token']['token'];

                  // 4. Save the fresh token over the old one in secure storage
                  await SecureStorageUtils.saveToken(token: newAccessToken ?? '');
                  await SecureStorageUtils.saveRefreshToken(refreshToken: newRefreshToken ?? '');

                  log("✅ Token refresh successful. Releasing waiting requests.");

                  // Satisfy the completer contract to broadcast token down the awaiting line
                  _refreshTokenCompleter?.complete(newAccessToken);

                }


                // on DioException catch (e) {
                //   final statusCode = e.response!.statusCode;
                //   print('path:::::${e.requestOptions.path}>>>>${e.requestOptions.baseUrl}');
                //   print('status code:::::$statusCode>>>>');
                //   log('full error response::::${e.response}>>>>');
                // }


                catch (refreshError) {
                  log("🚨 Refresh token process completely failed: $refreshError");
                  _refreshTokenCompleter?.complete(null);

                  if (Utilities.unauthorizedFlag == false) {
                    sessionExpired();
                  }

                  return handler.next(error);
                } finally {

                  // Tear down flags to unlock the gate system for future cycles
                  _isRefreshing = false;
                  _refreshTokenCompleter = null;

                }
              }
              else {

                // Subsequent concurrent calls arriving while the master token call is in flight
                log("⏳ Concurrent 401 hit detected. Parking request to await fresh token updates...");

                // Suspend execution safely until the leader request wakes this up
                newAccessToken = await _refreshTokenCompleter?.future;
              }

              // --- ORIGINAL REQUEST REPLAY ENGINE ---
              if (newAccessToken != null) {
                final requestOptions = error.requestOptions;
                requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

                try {
                  // Retry the network call with the fresh token
                  final retryResponse = await client.fetch(requestOptions);
                  return handler.resolve(retryResponse);
                } on DioException catch (retryError) {
                  log("🚨 The retried request failed down stream with status: ${retryError.response?.statusCode}");
                  // Forward the error safely into your main networkRequestManager catch block
                  return handler.next(retryError);
                } catch (customError) {
                  return handler.next(error);
                }

              } else {
                return handler.next(error);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> networkRequestManager(
      RequestType requestType,
      String requestUrl, {
        dynamic body,
        queryParameters,
        bool useAuth = true,
        bool useGuestToken = false,
        File? backFile,
        bool retrieveResponse = false,
        bool retrieveUnauthorizedResponse = false,
        Map<String, dynamic>? extraHeaders,
      }) async {
    final baseUrl = AppConfig.baseUrl;
    final url = '$baseUrl$requestUrl';


   print("Url: $url, Body: $body, Query: $queryParameters, useAuth: $useAuth");

    final remoteService = locator<RemoteConfigService>();

    if(remoteService.usePinning){
      // SSL PINNING CHECK
      try {
        final String secure = await HttpCertificatePinning.check(
          serverURL: baseUrl,
          sha: SHA.SHA256,
          allowedSHAFingerprints: remoteService.allowedFingerprints,
          timeout: 10,
        );
        log("🔒 SSL Pinning Status: $secure");
      } catch (e) {
        if (e.toString().contains('NO_INTERNET')) {
          log("📡 Network Error: No internet connection detected.");
          throw ("No internet connection. Please check your network settings and try again.");
        }

        log("🚨 SSL PINNING FAILED: Connection rejected for security. Error: $e");
        throw ("Secure connection could not be established. If you are using a proxy or VPN, please disable it and try again.");
      }
    }

    try {
      Map<String, dynamic> apiResponse;
      Response response;
      final options = Options(extra: {"useAuth": useAuth, "useGuestToken": useGuestToken}, headers: extraHeaders);

      switch (requestType) {
        case RequestType.get:
          response = await client.get(url, queryParameters: queryParameters, options: options);
          break;
        case RequestType.post:
        case RequestType.multiPartPost:
          response = await client.post(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.put:
          response = await client.put(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.patch:
          response = await client.patch(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.delete:
          response = await client.delete(url, data: body, queryParameters: queryParameters, options: options);
          break;
      }

      apiResponse = response.data;
      log("${requestType.name} response: $apiResponse");
      return apiResponse;
    } on TimeoutException {
      throw ("Network timed out, please check your network connection and try again");
    } on DioException catch (e) {
      //debugPrint('code: ${e.response?.statusCode}');

      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ("Network timed out, please check your network connection and try again");
      }

      if (e.type == DioExceptionType.unknown && e.message?.contains('SocketException') == true) {
        throw ("No internet connection, please check your network connection and try again");
      }

      if (e.response != null) {
        final statusCode = e.response!.statusCode!;
        final responseData = e.response!.data;

        if (statusCode == 400) {
          if (retrieveResponse) return responseData;
          throw (responseData['message']);
        } else if (statusCode == 401) {
          if (Utilities.unauthorizedFlag == false) sessionExpired();
          if (retrieveUnauthorizedResponse) return responseData;
          throw (responseData['message']);
        } else if (statusCode == 403 || statusCode == 404) {
          throw (responseData['message'] ?? "Resource not available");
        } else if (statusCode.isBetween(402, 422)) {
          throw (responseData['message'] ?? "Invalid credentials");
        } else if (statusCode.isBetween(500, 599)) {
          throw (statusCode == 502
              ? "We are unable to process request at this time, please try again later"
              : responseData['message'] ?? "Server error, please try again later");
        } else {
          throw ("Unable to process request, ${responseData['message'] ?? 'Unknown error'}");
        }
      } else {
        throw ("An unexpected error occurred");
      }
    } catch (e) {
      throw ("An error occurred while processing this request");
    }
  }
}

sessionExpired() {
  Utilities.unauthorizedFlag = true;
  NavigationService navigationService = locator<NavigationService>();
  navigationService.pushAndClearAllRoutes(
    routeName: NamedRoutes.login,
    arguments: true,
  );
}
