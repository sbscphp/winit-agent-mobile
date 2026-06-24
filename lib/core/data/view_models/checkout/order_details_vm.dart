import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/game_data_provider.dart';
import 'package:winit_agent/core/data/models/data/purchase_data.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../services/geolocator_service.dart';
import '../../states/base_state.dart';


class OrderDetailsVm extends BaseState {

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //order details
  PurchaseData? purchaseData;

  //values
  DateTime get ticketPurchaseDate => purchaseData?.order?.createdAt ?? DateTime.now();
  String get transactionId => purchaseData?.order?.transactionId ?? 'N/A';
  String get agentId => purchaseData?.agentId ?? 'N/A';
  String get gameName => purchaseData?.gameCategoryName ?? 'N/A';
  int get ticketCount => purchaseData?.order?.ticketsCount ?? 0;
  double get paidAmount => double.tryParse(purchaseData?.order?.paidAmount?.toString() ?? '0') ?? 0;


  //fetch payment breakdown
  purchaseFromAccount(
      {
        required String gameId,
        required int quantity,
        required String pin,
        required String customerId,
      }) async {

    setState(ViewState.busy);

    final pos = await locator<GeoLocatorService>().getCurrentLocation();

    final details = {
      "game_id": gameId, //ac56fd63-4230-4b77-9847-e456a71efd27 local //51dce84d-1d39-43aa-8235-6a9d21ff7585 server
      "transaction_pin": pin,
      "customer_id": customerId, //local d2e5e854-f924-488f-b1ac-2d27513bce5e, server 8b7c5264-ca3d-4c12-bafa-05bf6ca11bd0
      "platform": "mobile", //web,mobile,pos,others
      "payment_method": "account", //paystack,account
      "quantity": quantity,
    };

    if(pos != null){
      details['geolocation'] = {
        "lat": pos.latitude,
        "lng": pos.longitude
      };
    }

    await _gameDp.purchaseFromWallet(details: details).then(
            (response) async {
          _message = response.message ?? defaultSuccessMessage;
          purchaseData = response.data;
          setState(ViewState.retrieved);
        }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //fetch ticket details
  fetchTicketDetails(
      {
        required String? id,
      }) async {

    setSecondState(ViewState.busy);

    await _gameDp.fetchTicketDetails(id: id).then(
            (response) async {
          _message = response.message ?? defaultSuccessMessage;
          purchaseData = response.data;
          setSecondState(ViewState.retrieved);
        }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }



}

final orderDetailsViewModel = ChangeNotifierProvider<OrderDetailsVm>((ref) {
  return OrderDetailsVm();
});
