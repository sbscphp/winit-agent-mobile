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
    platformAccount = _accountInformation?.platformAccount;
    _bankAccounts = _accountInformation?.bankInformation ?? [];
    notifyListeners();
  }


  //platform account(default wallet for Agent)
  BankAccount? platformAccount;


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
    bool fromOnboarding = false
  }) async {
    setSecondState(ViewState.busy);
    await _profileDp.deleteBankAccount(id: _bankAccounts[index].uuid, fromOnboarding: fromOnboarding).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      //remove from list
      _bankAccounts.removeAt(index);
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }









  // //update personal info
  // updatePersonalInfo({
  //   required String otherEmail,
  //   required String otherPhone,
  //   required String? lga,
  //   required String address,
  //   required String landmark
  // }) async {
  //
  //   if(lga == null){
  //     _message = 'Kindly select a local government area to proceed';
  //     setState(ViewState.error);
  //     return;
  //   }
  //
  //   setState(ViewState.busy);
  //   final details = {
  //     "lga_of_residence": lga,
  //     "address": address,
  //     "landmark": landmark
  //   };
  //
  //   if(otherPhone.isNotEmpty){
  //     details["other_phone_number"] = Utilities.cleanPhoneNumber(phoneNumber: otherPhone);
  //   }
  //
  //   if(otherEmail.isNotEmpty){
  //     details["other_email"] = otherEmail;
  //   }
  //
  //   await _profileDp
  //       .updateInformation(details: details)
  //       .then((response) {
  //     _message = response.message ?? defaultSuccessMessage;
  //     _user = response.data?.personalInformation;
  //     setState(ViewState.retrieved);
  //   }).catchError((e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }







}

final bankAccountDetailsViewModel = ChangeNotifierProvider<BankAccountDetailsVm>((ref){
  return BankAccountDetailsVm();
});