import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/models/transaction.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';



class WalletTransactionsVm extends BaseState{

  //wallet data provider
  final WalletDataProvider _walletDp = locator<WalletDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //transactions
  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  //selected transaction
  Transaction? selectedTransaction;




  //fetch transactions
  fetchTransactions({bool firstCall = true, bool refreshUi = true, required String? id}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _walletDp.fetchWalletTransactions(
      pageNumber: pageNumber,
      id: id
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _transactions = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _transactions.addAll(response.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }














}

final walletTransactionsViewModel = ChangeNotifierProvider<WalletTransactionsVm>((ref){
  return WalletTransactionsVm();
});