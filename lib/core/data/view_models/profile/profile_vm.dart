import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/business_information.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../models/data/login_data.dart';
import '../../models/user.dart';

class ProfileVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //login data
  LoginData? _loginData;
  LoginData? get loginData => _loginData;
  set loginData(LoginData? val){
    _loginData = val;
    _user = _loginData?.user?.personalInformation;
    _businessInformation = _loginData?.user?.businessInformation;
    notifyListeners();
  }

  //user
  User? _user;
  User? get user => _user;

  //business information
  BusinessInformation? _businessInformation;
  BusinessInformation? get businessInformation => _businessInformation;


  //personal info
  //String get onboardingStep => _user?.registrationStep ?? '';
  String get phone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _user?.phoneNumber ?? '');
  String get phone2 => Utilities.formatSavedUserPhoneNumber(phoneNumber: _user?.otherPhoneNumber ?? '');
  String get firstname => _user?.firstname ?? 'N/A';
  String get lastname => _user?.lastname ?? 'N/A';
  String get email => _user?.email ?? '';
  String get email2 => _user?.otherEmail ?? '';
  String get userId => _user?.uuid ?? '';
  String get avatar => _user?.avatar ?? '';
  String get address => _user?.address ?? '';
  String get landmark => _user?.landmark ?? '';
  String? get lga => _user?.lgaOfResidence;

  //business info
  String get tinNumber => _businessInformation?.tinNumber ?? '';
  String get bizPhone => Utilities.formatSavedUserPhoneNumber(phoneNumber: _businessInformation?.businessPhone ?? '');
  String get bizPhone2 => Utilities.formatSavedUserPhoneNumber(phoneNumber: _businessInformation?.businessPhoneNumber2 ?? '');
  String get bizEmail => _businessInformation?.businessEmail ?? '';
  String get bizEmail2 => _businessInformation?.businessEmail2 ?? '';
  String get bizAddress => _businessInformation?.businessAddress ?? '';
  String get bizLandmark => _businessInformation?.businessLandmark ?? '';
  String get bizLga => _businessInformation?.businessLgaOfResidence ?? '';
  List<String> get selectedPosAgents => _businessInformation?.posAgents ?? [];
  List<String> get selectedFinancialAgents => _businessInformation?.lotteryAgents ?? [];

  bool get hasTransactionPin => _user?.hasTransactionPin ?? false;




  //update personal info
  updatePersonalInfo({
    required String otherEmail,
    required String otherPhone,
    required String? lga,
    required String address,
    required String landmark
  }) async {

    if(lga == null){
      _message = 'Kindly select a local government area to proceed';
      setState(ViewState.error);
      return;
    }

    setState(ViewState.busy);
    final details = {
      "lga_of_residence": lga,
      "address": address,
      "landmark": landmark
    };

    if(otherPhone.isNotEmpty){
      details["other_phone_number"] = Utilities.cleanPhoneNumber(phoneNumber: otherPhone);
    }

    if(otherEmail.isNotEmpty){
      details["other_email"] = otherEmail;
    }

    await _profileDp
        .updateInformation(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _user = response.data?.personalInformation;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //update business information
  updateBusinessInfo({
    required String bizEmail1,
    required String bizEmail2,
    required String bizPhone1,
    required String bizPhone2,
    required String? lga,
    required String bizAddress,
    required String bizLandmark,
    required String tinNumber,
    required String otherAgents,
    required List<String> posAgents,
    required List<String> lotteryAgents
  }) async {

    if(lga == null){
      _message = 'Kindly select a local government area to proceed';
      setState(ViewState.error);
      return;
    }

    setState(ViewState.busy);

    final Map<String, dynamic> details = {
      "tin_number": tinNumber,
      "business_phone": Utilities.cleanPhoneNumber(phoneNumber: bizPhone1),
      "business_email": bizEmail1,
      "business_email_2": bizEmail2,
      "business_state_of_residence": "Lagos", //todo: ask Juwon
      "business_lga_of_residence": lga,
      "business_address": bizAddress,
      "business_landmark": bizLandmark,
    };

    if(bizPhone1.isNotEmpty){
      details["business_phone"] = Utilities.cleanPhoneNumber(phoneNumber: bizPhone1);
    }

    if(bizPhone2.isNotEmpty){
      details["business_phone_number_2"] = Utilities.cleanPhoneNumber(phoneNumber: bizPhone2);
    }

    if(bizEmail2.isNotEmpty){
      details["business_email_2"] = bizEmail2;
    }

    if(posAgents.isNotEmpty){
      details["pos_agents"] = posAgents;
    }

    if(lotteryAgents.isNotEmpty){
      details["lottery_agents"] = lotteryAgents;
    }

    if(otherAgents.isNotEmpty){
      details["other_agents"] = [otherAgents];
    }


    await _profileDp
        .updateInformation(details: details, isPersonalInfo: false)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _businessInformation = response.data?.businessInformation;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      log('full error:::$_message');
      setState(ViewState.error);
    });
  }





}

final profileViewModel = ChangeNotifierProvider<ProfileVm>((ref){
  return ProfileVm();
});