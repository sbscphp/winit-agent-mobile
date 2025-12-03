import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/bvn_data.dart';
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

  //bvn data
  IdentityResultData? _identityResultData;

  String get bvnFirstname => _identityResultData?.returnedData?.firstname ?? 'N/A';
  String get bvnLastname => _identityResultData?.returnedData?.lastname ?? 'N/A';
  String get bvnPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _identityResultData?.returnedData?.phoneNumber ?? '');
  String get bvnGender => _identityResultData?.returnedData?.gender ?? 'N/A';
  String get bvnDob => _identityResultData?.returnedData?.birthdate ?? 'N/A';

  bool get firstnameMatched => _identityResultData?.fieldMatches?.firstname ?? false;
  bool get lastnameMatched => _identityResultData?.fieldMatches?.lastname ?? false;
  bool get phoneMatched => _identityResultData?.fieldMatches?.phone ?? false;
  bool get genderMatched => _identityResultData?.fieldMatches?.gender ?? false;
  bool get dobMatched => _identityResultData?.fieldMatches?.birthdate ?? false;

  //nin data
  String get ninFirstname => _identityResultData?.ninDetails?.firstname ?? 'N/A';
  String get ninLastname => _identityResultData?.ninDetails?.lastname ?? 'N/A';
  String get ninPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _identityResultData?.ninDetails?.phoneNumber ?? '');
  String get ninGender => _identityResultData?.ninDetails?.gender ?? 'N/A';
  String get ninDob => _identityResultData?.ninDetails?.birthdate ?? 'N/A';



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
      _identityResultData = response.data;
      _isBvnVerified = _identityResultData?.isMatch ?? false;
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