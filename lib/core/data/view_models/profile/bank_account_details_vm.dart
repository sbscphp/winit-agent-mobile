import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/account_information.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';


class BankAccountDetailsVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //resolved account name
  String accountName = '';

  //account information
  AccountInformation? _accountInformation;
  AccountInformation? get accountInformation => _accountInformation;
  set accountInformation(AccountInformation? val){
    _accountInformation = val;
    _bankAccounts = _accountInformation?.bankInformation ?? [];
    notifyListeners();
  }


  //bank accounts
  List<BankAccount> _bankAccounts = [];
  List<BankAccount> get bankAccounts => _bankAccounts;


  //add bank account
  addBankAccount({
    required String accountNumber,
    required String bankCode,
    bool saveToDb = true,
    required bool isDefault,
    bool isVerifyingAccount = false
  }) async {
    setState(ViewState.busy);

    final params = {
      'account_number': accountNumber,
      'bank_code':bankCode,
      'save_to_db': saveToDb,
      'is_default': isDefault
    };
    await _profileDp.addBankAccount(filterParams: params).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      if(isVerifyingAccount){
        accountName = response.data?.accountName ?? '';
      }else{
        //update bank account list
        _bankAccounts.add(response.data ?? BankAccount());
      }
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


  deleteBankAccount({
    required int index,
    String? pin,
    bool fromOnboarding = false
  }) async {
    setSecondState(ViewState.busy);
    Map<String, dynamic>? details;
    if(!fromOnboarding){
      details = {
        'transaction_pin': pin
      };
    }
    await _profileDp.deleteBankAccount(id: _bankAccounts[index].uuid, fromOnboarding: fromOnboarding, details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      //remove from list
      _bankAccounts.removeAt(index);
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }

}

final bankAccountDetailsViewModel = ChangeNotifierProvider<BankAccountDetailsVm>((ref){
  return BankAccountDetailsVm();
});