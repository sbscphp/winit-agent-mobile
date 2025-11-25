import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../models/user.dart';

class ProfileVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //user
  User? _user;
  User? get user => _user;
  set user(User? val){
    _user = val;
    notifyListeners();
  }



  //values
  String get onboardingStep => _user?.registrationStep ?? '';
  String get phone => _user?.phoneNumber ?? '';
  String get firstname => _user?.firstname ?? 'N/A';
  String get lastname => _user?.lastname ?? 'N/A';
  String get email => _user?.email ?? 'N/A';
  String get userId => _user?.uuid ?? 'N/A';
  String get avatar => _user?.avatar ?? '';


  //update personal info
  updatePersonalInfo({
    required String otherEmail,
    required String otherPhone,
    required String? lga,
    required String address,
    required String landmark
  }) async {

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
      //todo: update personal info variable
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }





}

final profileViewModel = ChangeNotifierProvider.autoDispose<ProfileVm>((ref){
  return ProfileVm();
});