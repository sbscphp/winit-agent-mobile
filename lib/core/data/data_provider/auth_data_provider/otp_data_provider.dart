import 'dart:async';
import 'dart:convert';
import 'package:winit_agent/core/constants/api_routes.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/enum/request_type.dart';
import 'package:winit_agent/core/data/models/data/otp_data.dart';
import 'package:winit_agent/core/data/network_manager/network_manager.dart';
import '../../models/api_response.dart';


class OtpDataProvider{

  //send otp
  Future<ApiResponse<OtpData>> sendOtp({required OtpType otpType, required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<OtpData>>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.createAccount){
        //send otp for create account
        apiRoute = ApiRoutes.sendRegistrationOtp;
      }
      if(otpType == OtpType.forgotTransactionPin){
        //send otp for forgot transaction pin
        apiRoute = ApiRoutes.sendForgotPinOtp;
      }
      if(otpType == OtpType.forgotPassword){
        //send otp for forgot password
        apiRoute = ApiRoutes.sendForgotPasswordOtp;
      }

      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, apiRoute,
          useAuth: isOtpUseAuth(otpType: otpType),
          body: jsonEncode(details)
      );
      var result = ApiResponse<OtpData>.fromJson(
        response,
            (data) => OtpData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //resend otp
  Future<ApiResponse<OtpData>> resendOtp({required OtpType otpType, required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<OtpData>>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.createAccount){
        //resend otp for create account
        apiRoute = ApiRoutes.resendRegistrationOtp;
      }

      if(otpType == OtpType.forgotTransactionPin){
        //resend otp for forgot transaction pin
        apiRoute = ApiRoutes.resendForgotPinOtp;
      }

      if(otpType == OtpType.forgotPassword){
        //resend otp for forgot password
        apiRoute = ApiRoutes.resendForgotPasswordOtp;
      }

      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, apiRoute,
          useAuth: isOtpUseAuth(otpType: otpType),
          body: jsonEncode(details)
      );
      var result = ApiResponse<OtpData>.fromJson(
        response,
            (data) => OtpData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse<OtpData>> verifyOtp({required OtpType otpType, required Map<String, dynamic> details, String? userId}) async {
    var completer = Completer<ApiResponse<OtpData>>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.createAccount){
        //send otp for create account
        apiRoute = ApiRoutes.verifyRegistrationOtp;
      }

      if(otpType == OtpType.forgotTransactionPin){
        //verify otp for forgot transaction pin
        apiRoute = ApiRoutes.verifyForgotPinOtp;
      }

      if(otpType == OtpType.forgotPassword){
        //verify otp for forgot password
        apiRoute = ApiRoutes.verifyForgotPasswordOtp(userId: userId);
      }


      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, apiRoute,
          useAuth: isOtpUseAuth(otpType: otpType),
          body: jsonEncode(details)
      );
      var result = ApiResponse<OtpData>.fromJson(
        response,
            (data) => OtpData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


  //validate otp
  // Future<DefaultResponse> validateOtp({required OtpType otpType, required Map<String, dynamic> details, required String? userId}) async {
  //   var completer = Completer<DefaultResponse>();
  //   try {
  //     String apiRoute = '';
  //     if(otpType == OtpType.forgotPassword){
  //       //validate otp for forgot password
  //       apiRoute = ApiRoutes.verifyForgotPasswordOtp(userId: userId);
  //     }
  //     if(otpType == OtpType.verifyEmail){
  //       //validate otp for email verification
  //       apiRoute = ApiRoutes.verifyOtpEmail;
  //     }
  //     if(otpType == OtpType.verifyPhone){
  //       //validate otp for phone verification
  //       apiRoute = ApiRoutes.verifyOtpPhone;
  //     }
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, apiRoute,
  //         useAuth: isOtpUseAuth(otpType: otpType),
  //         body:jsonEncode(details)
  //     );
  //     var result = DefaultResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }

  // returns flag for useAuth
  isOtpUseAuth({required OtpType otpType}) {
    switch (otpType) {
      case OtpType.forgotPassword:
      case OtpType.verifyEmail:
      case OtpType.verifyPhone:
      case OtpType.createAccount:
        return false;
      default:
        return true;
    }
  }
}