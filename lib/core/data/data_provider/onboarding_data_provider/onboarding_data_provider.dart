import 'dart:async';
import 'dart:convert';
import 'package:winit_agent/core/constants/api_routes.dart';
import 'package:winit_agent/core/data/enum/request_type.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/models/data/bvn_data.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/network_manager/network_manager.dart';
import '../../models/api_response.dart';




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

  //Complete NIN liveness check
  Future<ApiResponse> completeNinLiveness({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.completeNinLivenessCheck,
        body: jsonEncode(details)
      );
      var result = ApiResponse.fromJson(
          response,
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //bvn verification
  Future<ApiResponse<BvnData>> bvnVerification({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<BvnData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.bvnVerification,
          body: jsonEncode(details)
      );
      var result = ApiResponse<BvnData>.fromJson(
          response,
          null);
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
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}