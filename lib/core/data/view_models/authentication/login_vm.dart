import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/auth_data_provider/auth_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class LoginVm extends BaseState{

  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //data
  LoginData? loginData;

  //values
  String get onboardingStep => loginData?.user?.registrationStep ?? '';
  String get phone => loginData?.user?.phoneNumber ?? '';
  String get firstname => loginData?.user?.firstname ?? 'N/A';
  String get lastname => loginData?.user?.lastname ?? 'N/A';
  String get email => loginData?.user?.email ?? 'N/A';
  String get userId => loginData?.user?.uuid ?? 'N/A';


  //login
  login({
    required String loginChoice,
    required String pwd,
  }) async {

    setState(ViewState.busy);
    final details = {
      "username": loginChoice, //local - mainagent1@yopmail.com, server - superagent@yopmail.com
      "password":pwd, // password, P@ssw0rd
      "remember_me": true
    };

    await _authDp
        .login(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      loginData = response.data;
      SecureStorageUtils.saveToken(token: loginData?.accessToken ?? '');
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }





}

final loginViewModel = ChangeNotifierProvider.autoDispose<LoginVm>((ref){
  return LoginVm();
});