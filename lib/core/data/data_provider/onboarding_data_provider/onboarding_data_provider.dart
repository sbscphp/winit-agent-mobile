import 'dart:async';
import 'dart:convert';
import 'package:qoreidsdk/qoreidsdk.dart';
import 'package:uuid/uuid.dart';
import 'package:winit_agent/core/constants/api_routes.dart';
import 'package:winit_agent/core/data/enum/request_type.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/models/data/bvn_data.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/network_manager/network_manager.dart';
import '../../models/api_response.dart';
import '../../models/data/qore_data.dart';
import '../../models/user.dart';




class OnboardingDataProvider{

  //register a new agent
  Future<ApiResponse<LoginData>> register({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<LoginData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.register,
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

  //fetch session token for NIN liveliness check
  Future<ApiResponse<QoreData>> fetchSessionToken() async {
    var completer = Completer<ApiResponse<QoreData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.fetchSessionToken,
        useAuth: true,
        extraHeaders: {
          "QoreID-Idempotency-Key": Uuid().v4()
        },
      );
      var result = ApiResponse<QoreData>.fromJson(
        response,
            (data) => QoreData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //Complete NIN liveness check
  Future<ApiResponse<User>> getNinValidity() async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.getNinValidity,
          useAuth: true,
      );
      var result = ApiResponse<User>.fromJson(
        response,
            (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //bvn verification
  Future<ApiResponse<IdentityResultData>> bvnVerification({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<IdentityResultData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.bvnVerification,
          body: jsonEncode(details)
      );
      var result = ApiResponse<IdentityResultData>.fromJson(
          response,
            (data) => IdentityResultData.fromJson(data as Map<String, dynamic>),);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //complete onboarding
  Future<ApiResponse<BankAccount>> completeOnboarding() async {
    var completer = Completer<ApiResponse<BankAccount>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.completeOnboarding,
      );
      var result = ApiResponse<BankAccount>.fromJson(
          response,
              (data) => BankAccount.fromJson(data as Map<String, dynamic>));
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}