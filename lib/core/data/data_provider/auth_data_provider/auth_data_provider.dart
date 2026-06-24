
import 'dart:async';
import 'dart:convert';

import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/api_response.dart';
import '../../models/data/login_data.dart';
import '../../network_manager/network_manager.dart';

class AuthDataProvider{

  Future<ApiResponse<LoginData>> login({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<LoginData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.login,
          useAuth: false,
          body: jsonEncode(details)
      );
      var result = ApiResponse<LoginData>.fromJson(
        response,
            (data) => LoginData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse> createPassword({required Map<String, dynamic> details, String? userId}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.createPassword(userId: userId),
          useAuth: false,
          body: jsonEncode(details)
      );
      var result = ApiResponse.fromJson(
        response,
            null,
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse> logout() async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.logout,
          useAuth: true,
      );
      var result = ApiResponse.fromJson(
        response,
        null,
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}