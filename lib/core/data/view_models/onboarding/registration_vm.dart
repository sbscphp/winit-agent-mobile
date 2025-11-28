import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class RegistrationVm extends BaseState{

  //onboarding data provider
  final OnboardingDataProvider _onboardingDp = locator<OnboardingDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //data
  LoginData? loginData;

  //default wallet
  BankAccount? onboardingCompletion;

  //register agent
  register({
    required String phone,
    required String email,
    required String refCode,
    required String pwd,
    required String confirmPwd
  }) async {

    setState(ViewState.busy);
    final details = {
      "email":email,
      "phone_number":Utilities.cleanPhoneNumber(phoneNumber: phone),
      "password":pwd,
      "password_confirmation":confirmPwd,
    };

    if(refCode.isNotEmpty){
      details["referral_code"] = refCode;
    }

    await _onboardingDp
        .register(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      loginData = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //complete onboarding
  completeOnboarding() async {

    setSecondState(ViewState.busy);
    await _onboardingDp
        .completeOnboarding()
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      onboardingCompletion = response.data;
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }





}

final registrationViewModel = ChangeNotifierProvider.autoDispose<RegistrationVm>((ref){
  return RegistrationVm();
});