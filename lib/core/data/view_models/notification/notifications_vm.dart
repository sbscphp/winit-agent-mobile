import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/notification_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/models/app_notification.dart';
import 'package:winit_agent/core/data/models/transaction.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';



class NotificationsVm extends BaseState{

  //notification data provider
  final NotificationDataProvider _notificationsDp = locator<NotificationDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //notifications
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  //selected notification
  AppNotification? selectedNotification;




  //fetch notifications
  fetchNotifications({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _notificationsDp.fetchNotifications(
        pageNumber: pageNumber
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.notifications?.total ?? 0;
      if(firstCall){
        //populate list
        _notifications = response.data?.notifications?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _notifications.addAll(response.data?.notifications?.data ?? []);
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

final notificationsViewModel = ChangeNotifierProvider<NotificationsVm>((ref){
  return NotificationsVm();
});