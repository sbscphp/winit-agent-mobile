import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../enum/view_state.dart';


class TransactionPinVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //current pin
  String? currentPin;






  //set transaction pin
  setTransactionPin({
    required String pin,
  }) async {

    setState(ViewState.busy);

    final details = {
      "transaction_pin": pin,
      "confirm_transaction_pin": pin
    };

    await _profileDp
        .setTransactionPin(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //validate transaction pin
  validateTransactionPin({
    required String pin,
  }) async {

    setState(ViewState.busy);

    final details = {
      "transaction_pin": pin,
    };

    await _profileDp
        .validateTransactionPin(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      currentPin = pin;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //update transaction pin
  updateTransactionPin({
    required String newPin,
  }) async {

    setState(ViewState.busy);

    final details = {
      "old_transaction_pin": currentPin,
      "transaction_pin": newPin
    };

    await _profileDp
        .updateTransactionPin(details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }







}

final transactionPinViewModel = ChangeNotifierProvider<TransactionPinVm>((ref){
  return TransactionPinVm();
});