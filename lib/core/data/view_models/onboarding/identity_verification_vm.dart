import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/bvn_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

import '../../models/user.dart';

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

  //nin data
  User? _ninData;
  User? get ninData => _ninData;
  set ninData(User? val){
    _ninData = val;
    _ninData?.phone = _ninData?.phoneNumber;
    notifyListeners();
  }

  String get bvnFirstname => _identityResultData?.returnedData?.firstname ?? 'N/A';
  String get bvnLastname => _identityResultData?.returnedData?.lastname ?? 'N/A';
  String get bvnPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _identityResultData?.returnedData?.phone ?? '');
  String get bvnGender => _identityResultData?.returnedData?.gender ?? 'N/A';
  String get bvnDob => _identityResultData?.returnedData?.birthdate ?? 'N/A';

  bool get firstnameMatched => _identityResultData?.fieldMatches?.firstname ?? false;
  bool get lastnameMatched => _identityResultData?.fieldMatches?.lastname ?? false;
  bool get phoneMatched => _identityResultData?.fieldMatches?.phone ?? false;
  bool get genderMatched => _identityResultData?.fieldMatches?.gender ?? false;
  bool get dobMatched => _identityResultData?.fieldMatches?.birthdate ?? false;

  //nin data with bvn
  String get ninFirstname => _identityResultData?.ninDetails?.firstname ?? 'N/A';
  String get ninLastname => _identityResultData?.ninDetails?.lastname ?? 'N/A';
  String get ninPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _identityResultData?.ninDetails?.phone ?? '');
  String get ninGender => _identityResultData?.ninDetails?.gender ?? 'N/A';
  String get ninDob => _identityResultData?.ninDetails?.birthdate ?? 'N/A';

  //nin data
  String get nFirstname => _ninData?.firstname ?? 'N/A';
  String get nLastname => _ninData?.lastname ?? 'N/A';
  String get nPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _ninData?.phone ?? '');
  String get nGender => _ninData?.gender ?? 'N/A';
  String get nDob => _ninData?.birthdate ?? 'N/A';
  bool get ninVerificationPassed => _ninData?.passThreshold ?? false;
  double get matchPercentage => double.tryParse(_ninData?.matchPercentage?.toString() ?? '0') ?? 0;






  //complete NIN verification
  getNinValidity() async {
    setState(ViewState.busy);
    await _onboardingDp
        .getNinValidity()
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _ninData = response.data;
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
      log('bvn data:::${_identityResultData?.toJson().toString()}>>>');
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }





}

final identificationViewModel = ChangeNotifierProvider<IdentityVerificationVm>((ref){
  return IdentityVerificationVm();
});