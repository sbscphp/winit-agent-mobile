import 'dart:async';
import 'dart:convert';

import 'package:winit_agent/core/data/models/transaction.dart';
import 'package:winit_agent/core/data/models/platform_account.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/data/pagination_data.dart';
import '../network_manager/network_manager.dart';

class WalletDataProvider{

  //fetch wallet summary
  Future<ApiResponse<PlatformAccount>> fetchWalletSummary() async {
    var completer = Completer<ApiResponse<PlatformAccount>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchWalletSummary,

      );
      var result = ApiResponse<PlatformAccount>.fromJson(
        response,
            (data) => PlatformAccount.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch wallet transactions
  Future<ApiResponse<PaginationData<Transaction>>> fetchWalletTransactions({required int? pageNumber, String? filterParams, bool paginate = true}) async {
    var completer = Completer<ApiResponse<PaginationData<Transaction>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchWalletTransactions(
          pageNumber: pageNumber,
        paginate: paginate,
        filterParams: filterParams,
      ),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<Transaction>>.fromJson(
        response,
            (data) => PaginationData<Transaction>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => Transaction.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch purchase transaction
  Future<ApiResponse<List<Transaction>>> fetchPurchaseTransactions({String? filterParams}) async {
    var completer = Completer<ApiResponse<List<Transaction>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchWalletTransactions(pageNumber: 1, paginate: false, filterParams: filterParams),
      );
      var result = ApiResponse<List<Transaction>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => Transaction.fromJson(
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

  //withdraw
  Future<ApiResponse> withdraw({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.withdraw,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse.fromJson(
          response,
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}