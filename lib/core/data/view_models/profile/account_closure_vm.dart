import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/models/data/account_closure_data.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../enum/view_state.dart';


class AccountClosureVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //account closure data
  AccountClosureData? closureData;

  bool get canCloseAccount => closureData?.canInitiateClosure ?? false;


  //check account closure
  checkAccountClosureStatus() async {

    setState(ViewState.busy);

    await _profileDp
        .checkAccountClosureStatus()
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      closureData = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //close account
  closeAccount({required String pin}) async {

    setState(ViewState.busy);

    final details = {
      "pin": pin
    };

    await _profileDp
        .closeAccount(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //delete account
  deleteAccount({required String pin}) async {

    setSecondState(ViewState.busy);

    final details = {
      "pin": pin
    };

    await _profileDp
        .deleteAccount(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }














}

final accountClosureViewModel = ChangeNotifierProvider<AccountClosureVm>((ref){
  return AccountClosureVm();
});