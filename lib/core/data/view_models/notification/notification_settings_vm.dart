import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/models/notification_preference.dart';
import '../../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/notification_data_provider.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';




class NotificationSettingsVm extends BaseState{

  //notification data provider
  final NotificationDataProvider _notificationDp = locator<NotificationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //notification preference
  NotificationPreference? _settings;
  NotificationPreference? get settings => _settings;


  bool get general => _settings?.general?.toLowerCase() == 'true';
  bool get games => _settings?.games?.toLowerCase() == 'true';
  bool get ticketPurchase => _settings?.ticketPurchases?.toLowerCase() == 'true';
  bool get wallet => _settings?.wallet?.toLowerCase() == 'true';
  bool get commission => _settings?.commissionDisbursements?.toLowerCase() == 'true';
  bool get bonus => _settings?.bonusDisbursements?.toLowerCase() == 'true';


  //fetch notification settings
  fetchNotificationSettings() async {

    setState(ViewState.busy);

    await _notificationDp.fetchNotificationSettings().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _settings = response.data;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }



//update notification preference
  updateNotificationSettings(
      {
        bool general = true,
        bool games = true,
        bool ticketPurchase = true,
        bool wallet = true,
        bool commission = true,
        bool bonus = true,
      }) async {

    setSecondState(ViewState.busy);

    final details = {
      "general":  general ? "true":'false',
      "games":  games ? "true":'false',
      "ticket_purchases":  ticketPurchase ? "true":'false',
      "wallet":  wallet ? "true":'false',
      "commission_disbursements":  commission ? "true":'false',
      "bonus_disbursements":  bonus ? "true":'false',
      //"referrals": paymentTransactions ? "true":'false',
    };

    await _notificationDp.updateNotificationSettings(details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _settings = response.data;
      setSecondState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }



}

final notificationSettingsViewModel = ChangeNotifierProvider<NotificationSettingsVm>((ref){
  return NotificationSettingsVm();
});