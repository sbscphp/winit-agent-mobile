import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/models/transaction.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';


class TransactionFiltersVm extends BaseState{

  //wallet data provider
  final WalletDataProvider _walletDp = locator<WalletDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  String _purchaseMessage = '';
  String get purchaseMessage => _purchaseMessage;

  //list of filtered results(polls)
  List<Transaction> _filteredResults = [];
  List<Transaction> get filteredResults => _filteredResults;

  //list of purchase transactions
  List<Transaction> _purchaseTransactions = [];
  List<Transaction> get purchaseTransactions => _purchaseTransactions;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //filter options
  Map<String, dynamic> filterOptions = {};
  String selectedFilter = 'show all';

  bool _showFilteredList = false;
  bool get showFilteredList => _showFilteredList;
  set showFilteredList(bool val){
    _showFilteredList = val;
    notifyListeners();
  }

  //fetch 'purchase' transactions
  fetchPurchaseTransactions({bool showLoader = true}) async {
    if(showLoader)setSecondState(ViewState.busy);
    await _walletDp.fetchPurchaseTransactions(filterParams: 'purchase').then((response) async{
      _purchaseMessage = response.message ?? defaultSuccessMessage;
      _purchaseTransactions = response.data ?? [];
      setSecondState(ViewState.retrieved);
    }).catchError((e) {
      _purchaseMessage = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }

  //fetch filtered results(transactions)
  fetchFilteredResults({required bool hasWallet, bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      _showFilteredList = true;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    int filterIndex = getTransactionFilterOptions(includeWalletTransactions: hasWallet).indexOf(selectedFilter);
    //transactionFilterOptions.indexOf(selectedFilter);

    final filters = {
      'filter_by': getFilterValues(includeWalletTransactions: hasWallet)[filterIndex]
      //filterValues[filterIndex]
    };

    await _walletDp.fetchWalletTransactions(
        pageNumber: pageNumber,
        filterParams: Utilities.returnQueryString(params: filters),
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _filteredResults = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _filteredResults.addAll(response.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
      //debugPrint("length of filtered transactions::::${_filteredResults.length}>>>");
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }


  setFilterOptions({String? selectedCategory, String? startDate, String? endDate}){

    if(selectedCategory != null){
      filterOptions["filter_by_real"] = selectedCategory;
      if(selectedCategory.toLowerCase() == 'show all'){
        filterOptions.remove('filter_by');
      }else{
        filterOptions["filter_by"] = selectedCategory.toLowerCase() == 'draw in view' ? 'upcoming':'ended';
      }

    }

    if(startDate != null){
      filterOptions["start_date"] = startDate;
    }

    if(endDate != null){
      filterOptions["end_date"] = endDate;
    }

  }

  String title({required bool hasWallet}){
    int filterIndex = getTransactionFilterOptions(includeWalletTransactions: hasWallet).indexOf(selectedFilter);
    //transactionFilterOptions.indexOf(selectedFilter);
    final refWord = getFilterValues(includeWalletTransactions: hasWallet)[filterIndex];
    //filterValues[filterIndex];
    switch(refWord.toLowerCase()){
      case 'topup':
        return 'Wallet Top Up';
      case 'purchase':
        return 'Ticket Purchase';
      case 'withdrawal':
        return 'Fund Withdrawal';
      case 'commission':
        return 'Commission Transaction';
      case 'bonus':
        return 'Performance Commission';
      default:
        return 'Transactions';
    }
  }

  final List<String> transactionFilterOptions = [
    'Show All',
    'Ticket Purchase',
    'Wallet Top Up',
    'Commission',
    'Fund Withdrawal',
    'Performance Commission'
  ];

  final List<String> filterValues = [
    'Show All',
    'purchase',
    'topup',
    'commission',
    'withdrawal',
    'bonus'
  ];

  List<String> getTransactionFilterOptions({
    bool includeWalletTransactions = true,
  }) {
    if (includeWalletTransactions) {
      return transactionFilterOptions;
    }

    return transactionFilterOptions
        .where((item) => item != 'Wallet Top Up' && item != 'Fund Withdrawal')
        .toList();
  }

  List<String> getFilterValues({
    bool includeWalletTransactions = true,
  }) {
    if (includeWalletTransactions) {
      return filterValues;
    }

    return filterValues
        .where((item) => item != 'topup' && item != 'withdrawal')
        .toList();
  }

  clearFilters(){
    _showFilteredList = false;
    selectedFilter = 'show all';
    notifyListeners();
  }
}

final transactionFiltersViewModel = ChangeNotifierProvider.autoDispose<TransactionFiltersVm>((ref){
  return TransactionFiltersVm();
});