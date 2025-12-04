import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/data_provider/game_data_provider.dart';
import 'package:winit_agent/core/data/enum/checkout_type.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../models/data/checkout_data.dart';
import '../../models/payment_method.dart';
import '../../models/payment_summary.dart';
import '../../states/base_state.dart';


class PaymentVm extends BaseState {

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //payment method message
  String _paymentMethodMessage = '';
  String get paymentMethodMessage => _paymentMethodMessage;


  //payment breakdown
  PaymentSummary? paymentBreakdown;


  //checkout type
  CheckoutType? _checkoutType;
  CheckoutType? get checkoutType => _checkoutType;
  set checkoutType(CheckoutType? val){
    _checkoutType = val;
    notifyListeners();
  }


  //list of payment methods
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      logo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyr437qI2tB-wc6360hAovPKJml_4AUalJMQ&s',
      name: 'Paystack',
      paymentChannels: 'bank|bank_transfer|card|ussd'
    )
  ];
  List<PaymentMethod> get paymentMethods => _paymentMethods;

  //payment method
  PaymentMethod? _selectedPaymentMethod;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  set selectedPaymentMethod(PaymentMethod? val){
    _selectedPaymentMethod = val;
    notifyListeners();
  }

  //selected payment channel
  String? _selectedPaymentType;
  String? get selectedPaymentType => _selectedPaymentType;
  set selectedPaymentType(String? val){
    _selectedPaymentType = val;
    notifyListeners();
  }


  //list of payment types
  List<String> get paymentTypes => Utilities.parseStringToList(_selectedPaymentMethod?.paymentChannels ?? '');


  //checkout data(for paystack and flutterwave)
  CheckoutData? checkoutData;

  //checkout values
  String get authUrl => checkoutData?.authorizationUrl ?? '';
  String get reference => checkoutData?.reference ?? '';
  String get successRedirectUrl => checkoutData?.successRedirect ?? '';
  String get failureRedirectUrl => checkoutData?.failureRedirect ?? '';
  String get callbackUrl => checkoutData?.callback ?? '';
  String get orderId => checkoutData?.orderId ?? '';


  //payment breakdown values
  int get quantity => paymentBreakdown?.quantity ?? 1;
  double get totalAmount => double.tryParse(paymentBreakdown?.totalAmount?.toString() ?? '0') ?? 0;
  double get gameTicketDiscount => double.tryParse(paymentBreakdown?.gameTicketDiscount?.toString() ?? '0') ?? 0;
  double get promoAmount => double.tryParse(paymentBreakdown?.promoAmount?.toString() ?? '0') ?? 0;
  double get referralAmount => double.tryParse(paymentBreakdown?.referralAmountUsed?.toString() ?? '0') ?? 0;
  double get amountToPay => double.tryParse(paymentBreakdown?.amountToPay?.toString() ?? '0') ?? 0;


  //fetch payment methods
  // fetchPaymentMethods() async {
  //
  //   setThirdState(ViewState.busy);
  //
  //   await _paymentDp.fetchPaymentMethods().then(
  //           (response) async {
  //         _paymentMethodMessage = response.message ?? defaultSuccessMessage;
  //         _paymentMethods = response.data ?? [];
  //         reset();
  //         setThirdState(ViewState.retrieved);
  //       }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setThirdState(ViewState.error);
  //   });
  // }


  //fetch payment breakdown
  fetchPaymentBreakdown(
      {
        required String gameId,
        required int quantity,
      }) async {

    setState(ViewState.busy);

    final details = {
      "game_id": gameId,
      "quantity": quantity,
    };

    await _gameDp.fetchPaymentSummary(details: details).then(
        (response) async {
      _message = response.message ?? defaultSuccessMessage;
      paymentBreakdown = response.data;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //initiate checkout
  // initiateCheckout(
  //     {required String gameId}) async {
  //
  //   setSecondState(ViewState.busy);
  //
  //   final pos = await locator<GeoLocatorService>().getCurrentLocation();
  //
  //   final details = {
  //     "game_id": gameId,
  //     "platform": "mobile",
  //     "payment_method": selectedPaymentMethod?.slug?.toLowerCase(), //flutterwave, paystack
  //     "payment_channel": selectedPaymentType?.toLowerCase(), //ussd, card, bank transfer
  //     "quantity": quantity,
  //     "amount": amountToPay,
  //   };
  //
  //   if(promoCodeApplied != null){
  //     details['promo_code'] = promoCodeApplied;
  //   }
  //
  //   if(refAmountUsed != null){
  //     details['referral_balance_amount'] = refAmountUsed;
  //   }
  //
  //   if(pos != null){
  //     details['geolocation'] = {
  //       "lat": pos.latitude,
  //       "lng": pos.longitude
  //     };
  //   }
  //
  //
  //   await _paymentDp.initiateCheckout(details: details).then(
  //           (response) async {
  //         _message = response.message ?? defaultSuccessMessage;
  //         checkoutData = response.data;
  //         setSecondState(ViewState.retrieved);
  //       }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setSecondState(ViewState.error);
  //   });
  // }


  resetPaymentVariables(){
    _selectedPaymentMethod = null;
    _selectedPaymentType = null;
    checkoutType = null;
  }


  reset(){
    _selectedPaymentMethod = null;
    _selectedPaymentType = null;
    checkoutData = null;
    _checkoutType = null;
  }
}

final paymentViewModel = ChangeNotifierProvider<PaymentVm>((ref) {
  return PaymentVm();
});
