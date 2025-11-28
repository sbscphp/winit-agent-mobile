import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/platform_account.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';



class WalletVm extends BaseState{

  //wallet data provider
  final WalletDataProvider _walletDp = locator<WalletDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //account information
  PlatformAccount? _platformAccount;
  PlatformAccount? get platformAccount => _platformAccount;
  set platformAccount(PlatformAccount? val){
    _platformAccount = val;
    notifyListeners();
  }

  //wallet details
  double get walletBalance => double.tryParse(platformAccount?.accountBalance?.toString() ?? '0') ?? 0;
  double get addedAmount => double.tryParse(platformAccount?.lastPeriodDaysBalance?.toString() ?? '0') ?? 0;
  String get duration => platformAccount?.lastPeriodDays?.toString() ?? '';

  String get walletAccountName => platformAccount?.accountDetails?.accountName ?? 'N/A';
  String get walletAccountNumber => platformAccount?.accountDetails?.accountNumber ?? 'N/A';
  String get walletId => platformAccount?.accountDetails?.uuid ?? '';



  //fetch wallet summary
  fetchWalletSummary({bool showLoader = true}) async {
   if(showLoader)setState(ViewState.busy);
    await _walletDp.fetchWalletSummary().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _platformAccount = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }




}

final walletVm = ChangeNotifierProvider<WalletVm>((ref){
  return WalletVm();
});