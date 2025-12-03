import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/otp_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_provider/auth_data_provider/otp_data_provider.dart';

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
    String identifier = '',
    bool updateUi = true,
    Map<String, dynamic>? payload
  }) async {

   if(updateUi)setState(ViewState.busy);

   Map<String, dynamic> details = {};

   if(otpType == OtpType.forgotPassword){

     details = {
       "username": identifier
     };

   }
   else{

     details = {
       "type": type, //email, phone
       //"identifier": identifier //mainagent@yopmail.com, 2348126264973
     };

     if(otpType != OtpType.forgotTransactionPin){
       details['identifier'] = identifier;
     }

   }


    await _otpDataProvider
        .sendOtp(otpType: otpType, details: payload ?? details)
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
    String identifier = '',
    Map<String, dynamic>? payload
  }) async {

    setSecondState(ViewState.busy);

    Map<String, dynamic> details = {};

    if(otpType == OtpType.forgotPassword){

      details = {
        "username": identifier
      };

    }else{

      details = {
        "type": type, //email, phone
        //"identifier": identifier //mainagent@yopmail.com, 2348126264973
      };

      if(otpType != OtpType.forgotTransactionPin){
        details['identifier'] = identifier;
      }

    }



    await _otpDataProvider
        .resendOtp(otpType: otpType, details: payload ?? details)
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
    String identifier = '',
    required String otp,
    Map<String, dynamic>? payload
  }) async {

    setThirdState(ViewState.busy);

    Map<String, dynamic> details = {};

    if(otpType == OtpType.forgotPassword){

      details = {
        "code": otp
      };

    }
    else{

      details = {
        "otp": otp
      };

      if(otpType != OtpType.forgotTransactionPin){
        details['type'] = type;
        details['identifier'] = identifier;
      }
    }




    await _otpDataProvider
        .verifyOtp(otpType: otpType, details: payload ?? details, userId: otpData?.userId)
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
    if (otpType == OtpType.createAccount || otpType == OtpType.forgotPassword) {
      return "Enter OTP 🔐 🚀 ";
    }


    return "Enter OTP to Authenticate this Action";
  }

  //returns sub-title for otp screen
  String otpSubtitle({required OtpType otpType, bool isEmail = true}) {
    if(otpType == OtpType.createAccount){
      final hasIdentifier = otpData?.masked != null;
      return "We sent a 6 digit OTP to your phone Number ${hasIdentifier ? otpData?.masked : ''}. Kindly enter your OTP Below. ";
    }

    if(otpType == OtpType.forgotPassword){
      final hasIdentifier = otpData?.identifier != null;
      return "We sent a 6 digit OTP to your ${isEmail ? 'email':'phone number'} ${hasIdentifier ? otpData?.identifier : ''}, associated with WinIT.";
    }


    return "We’ve sent a unique code to your phone number. Please enter the code below";
  }
}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpVm>((ref) {
  return OtpVm();
});
