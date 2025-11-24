import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class IdentityVerificationVm extends BaseState{

  //onboarding data provider
  final OnboardingDataProvider _onboardingDp = locator<OnboardingDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //bvn verification status
  bool _isBvnVerified = false;
  bool get isBvnVerified => _isBvnVerified;



  //complete NIN verification
  completeNinVerification({
    required String photo,
  }) async {
    setState(ViewState.busy);
    final details = {
      "photoUrl": photo
    };

    await _onboardingDp
        .completeNinLiveness(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //bvn verification
  bvnVerification({
    required String bvn,
  }) async {
    setSecondState(ViewState.busy);
    final details = {
      "idNumber": bvn
    };

    await _onboardingDp
        .bvnVerification(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _isBvnVerified = 1 + 1 == 2; //todo: update
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }





}

final identificationViewModel = ChangeNotifierProvider.autoDispose<IdentityVerificationVm>((ref){
  return IdentityVerificationVm();
});