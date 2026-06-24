import 'dart:async';
import 'dart:convert';
import 'package:winit_agent/core/data/models/data/checkout_data.dart';
import 'package:winit_agent/core/data/models/data/purchase_data.dart';
import 'package:winit_agent/core/data/models/payment_summary.dart';

import '../../constants/api_routes.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/data/pagination_data.dart';
import '../models/game.dart';
import '../models/user.dart';
import '../network_manager/network_manager.dart';


class GameDataProvider{

  //fetch all games
  Future<ApiResponse<PaginationData<Game>>> fetchAllGames({required int? pageNumber, Map<String, dynamic>? filterParams}) async {
    var completer = Completer<ApiResponse<PaginationData<Game>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchGames(pageNumber: pageNumber, filterParams: Utilities.returnQueryString(params: filterParams ?? {})),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<Game>>.fromJson(
        response,
            (data) => PaginationData<Game>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => Game.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //create customer
  Future<ApiResponse<User>> createCustomer({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.createCustomer,
          useAuth: true,
        body: jsonEncode(details)
      );
      var result = ApiResponse<User>.fromJson(
        response,
            (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //search customer
  Future<ApiResponse<List<User>>> searchCustomer({required String? phone}) async {
    var completer = Completer<ApiResponse<List<User>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.searchCustomers(phone: phone),
      );
      var result = ApiResponse<List<User>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => User.fromJson(
          e as Map<String, dynamic>,
        ))
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch payment breakdown
  Future<ApiResponse<PaymentSummary>> fetchPaymentSummary({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<PaymentSummary>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.fetchPaymentSummary,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse<PaymentSummary>.fromJson(
        response,
            (data) => PaymentSummary.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //purchase from account(wallet)
  Future<ApiResponse<PurchaseData>> purchaseFromWallet({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<PurchaseData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.purchaseFromAccount,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse<PurchaseData>.fromJson(
        response,
            (data) => PurchaseData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //initiate pay-stack checkout
  Future<ApiResponse<CheckoutData>> initiatePayStackCheckout({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<CheckoutData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.initiatePayStackCheckout,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse<CheckoutData>.fromJson(
        response,
            (data) => CheckoutData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch ticket details
  Future<ApiResponse<PurchaseData>> fetchTicketDetails({required String? id}) async {
    var completer = Completer<ApiResponse<PurchaseData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchTicketDetails(id: id),
          useAuth: true,
      );
      var result = ApiResponse<PurchaseData>.fromJson(
        response,
            (data) => PurchaseData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


}