import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

import '../../data_provider/auth_data_provider/auth_data_provider.dart';

class PasswordVm extends BaseState{

  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  final List<String> _pwdRequirements = [
    "8 characters minimum",
    "Characters must include uppercase and lowercase.",
    "At least one digit and symbol (like !@#\$%^&*)"
  ];
  List<String> get pwdRequirements => _pwdRequirements;

  List<bool> _results = [false, false, false];
  List<bool> get results => _results;






  //create password
  createNewPassword(
      {required String pwd, required String confirmPwd, required String? userId}) async {

    setState(ViewState.busy);

    final details = {
      "password": pwd,
      "password_confirmation": confirmPwd
    };
    await _authDp.createPassword(details: details, userId: userId).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      //await SecureStorageUtils.savePassword(value: password);
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }









  //checks password requirement
  checkPassWordRequirement({required String password}){

    final hasMinLength = password.trim().length > 7;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    _results = [hasMinLength, (hasUpperCase && hasLowerCase), (hasNumber && hasSymbol)];
    notifyListeners();
  }

  //checks if all password requirement(s) passed
  bool isPwdValid(){
    bool isValid = true;
    for(bool r in _results){
      if(!r){
        isValid = false;
        break;
      }
    }
    return isValid;
  }






}

final passwordViewModel = ChangeNotifierProvider.autoDispose<PasswordVm>((ref){
  return PasswordVm();
});