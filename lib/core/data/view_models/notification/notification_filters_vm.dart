import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/models/app_notification.dart';
import 'package:winit_agent/core/data/models/transaction.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/notification_data_provider.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';


class NotificationFiltersVm extends BaseState{

  //wallet data provider
  final NotificationDataProvider _notificationsDp = locator<NotificationDataProvider>();

  //message
  String _message = '';
  String get message => _message;



  //list of filtered results(notifications)
  List<AppNotification> _filteredResults = [];
  List<AppNotification> get filteredResults => _filteredResults;

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


  //fetch filtered results(notifications)
  fetchFilteredResults({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      _showFilteredList = true;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }


    int filterIndex = notificationFilterOptions.indexOf(selectedFilter);


    final filters = {
      'filter_by': filterValues[filterIndex]
    };

    await _notificationsDp.fetchNotifications(
      pageNumber: pageNumber,
      filterParams: Utilities.returnQueryString(params: filters),
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.notifications?.total ?? 0;
      if(firstCall){
        //populate list
        _filteredResults = response.data?.notifications?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _filteredResults.addAll(response.data?.notifications?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
      debugPrint("length of filtered notifications::::${_filteredResults.length}>>>");
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

  String title(){
    switch(selectedFilter.toLowerCase()){
      case 'general_notification':
        return 'General Notification';
      case 'game_ticket_purchase':
        return 'Game Ticket Purchase';
      case 'wallet_notification':
        return 'Wallet Notification';
      case 'commission':
        return 'Commission';
      case 'bonus_income':
        return 'Performance Commission';
      default:
        return 'Notifications';
    }
  }

  final List<String> notificationFilterOptions = [
    'Show All',
    'General Notification',
    'Game Ticket Purchase',
    'Wallet Notification',
    'Commission',
    'Performance Commission'
  ];

  final List<String> filterValues = [
    'Show All',
    'general_notification',
    'game_ticket_purchase',
    'wallet_notification',
    'commission',
    'bonus_income'
  ];

  clearFilters(){
    _showFilteredList = false;
    selectedFilter = 'show all';
    notifyListeners();
  }
}

final notificationFiltersViewModel = ChangeNotifierProvider.autoDispose<NotificationFiltersVm>((ref){
  return NotificationFiltersVm();
});