import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/constants/secure_storage_constants.dart';
import 'package:winit_agent/core/data/data_provider/auth_data_provider/auth_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/data/login_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class Logout extends BaseState{

  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;






  //logout
  logout() async {

    setState(ViewState.busy);
    await _authDp
        .logout()
        .then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }





}

final logoutViewModel = ChangeNotifierProvider.autoDispose<Logout>((ref){
  return Logout();
});