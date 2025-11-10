import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpVm extends BaseState {
  //otp data provider
  //final OtpDataProvider _otpDataProvider = locator<OtpDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  DateTime get endTime => DateTime.now().add(const Duration(minutes: 15));

  //resends otp based on OtpType
  // resendOtp({
  //   required OtpType otpType,
  //   required int? userId,
  //   String? passKey,
  //   int? paymentId,
  // }) async {
  //   setState(ViewState.busy);
  //   Map<String, dynamic>? details;
  //   if(otpType == OtpType.upgradeAccountLimit){
  //     details = {
  //       'passkey': passKey,
  //       'resend': true
  //     };
  //   }
  //   await _otpDataProvider
  //       .resendOtp(otpType: otpType, userId: userId, paymentId: paymentId, details: details)
  //       .then((response) {
  //     _message = response.message ?? defaultSuccessMessage;
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }

  //validate otp based on OtpType
  // validateOtp(
  //     {required OtpType otpType,
  //     required int? userId,
  //     int? paymentId,
  //     required String otp,
  //     double? amount}) async {
  //   setState(ViewState.busy);
  //   Map<String, dynamic>? details;
  //   if(otpType == OtpType.upgradeAccountLimit){
  //     details = {'otp': otp, 'amount':amount};
  //   }else if(otpType == OtpType.deviceBinding){
  //     final deviceId = await Utilities.getDeviceId();
  //     details = {'code': otp, 'deviceID':deviceId};
  //   } else{
  //     details = {'code': otp};
  //   }
  //   await _otpDataProvider
  //       .validateOtp(
  //           otpType: otpType,
  //           userId: userId,
  //           paymentId: paymentId,
  //           otp: details)
  //       .then((response) {
  //     _message = response.message ?? defaultSuccessMessage;
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }


  //app bar title
  String appBarTitle({required OtpType otpType}) {
    if (otpType == OtpType.createAccount) {
      return "Create a WinIt Agent Account";
    }


    return "Otp";
  }

  //returns title for otp screen
  String otpTitle({required OtpType otpType}) {
    if (otpType == OtpType.createAccount) {
      return "Enter OTP 🔐 🚀 ";
    }


    return "Enter OTP to Authenticate this Action";
  }

  //returns sub-title for otp screen
  String otpSubtitle({required OtpType otpType, required String? identifier}) {
    final hasIdentifier = identifier != null;
    if(otpType == OtpType.createAccount){
      return "We sent a 6 digit OTP to your phone Number ${hasIdentifier ? identifier : ''}. Kindly enter your OTP Below. ";
    }


    return "We’ve sent a unique code to your email. Please enter the code below";
  }
}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpVm>((ref) {
  return OtpVm();
});
