import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/otp_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_provider/otp_data_provider.dart';

class OtpVm extends BaseState {

  //otp data provider
  final OtpDataProvider _otpDataProvider = locator<OtpDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //otp data
  OtpData? otpData;

  DateTime get endTime => DateTime.now().add(Duration(minutes: int.tryParse(otpData?.minutes ?? '5') ?? 5));

  //send otp based on OtpType
  sendOtp({
    required OtpType otpType,
    String type = 'phone',
    required String identifier,
    bool updateUi = true
  }) async {

   if(updateUi)setState(ViewState.busy);

    final details = {
      "type": type, //email, phone
      "identifier": identifier //mainagent@yopmail.com, 2348126264973
    };

    await _otpDataProvider
        .sendOtp(otpType: otpType, details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      otpData = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //resend otp
  resendOtp({
    required OtpType otpType,
    String type = 'phone',
    required String identifier
  }) async {

    setSecondState(ViewState.busy);

    final details = {
      "type": type, //email, phone
      "identifier": identifier //mainagent@yopmail.com, 2348126264973
    };

    await _otpDataProvider
        .resendOtp(otpType: otpType, details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      otpData = response.data;
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }

  //resend otp
  verifyOtp({
    required OtpType otpType,
    String type = 'phone',
    required String identifier,
    required String otp
  }) async {

    setThirdState(ViewState.busy);

    final details = {
      "type": type, //email, phone
      "identifier": identifier, //mainagent@yopmail.com, 2348126264973
      "otp": otp
    };

    await _otpDataProvider
        .verifyOtp(otpType: otpType, details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      otpData = response.data;
      setThirdState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setThirdState(ViewState.error);
    });
  }


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
  String otpSubtitle({required OtpType otpType}) {
    final hasIdentifier = otpData?.masked != null;
    if(otpType == OtpType.createAccount){
      return "We sent a 6 digit OTP to your phone Number ${hasIdentifier ? otpData?.masked : ''}. Kindly enter your OTP Below. ";
    }


    return "We’ve sent a unique code to your phone number. Please enter the code below";
  }
}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpVm>((ref) {
  return OtpVm();
});
