
import 'dart:async';
import 'dart:convert';

import 'package:winit_agent/core/data/models/data/information_data.dart';

import '../../../constants/api_routes.dart';
import '../../../utilities/utilities.dart';
import '../../enum/request_type.dart';
import '../../models/api_response.dart';
import '../../models/bank_account.dart';
import '../../network_manager/network_manager.dart';

class ProfileDataProvider{

  Future<ApiResponse<InformationData>> updateInformation({required Map<String, dynamic> details, bool isPersonalInfo = true}) async {
    var completer = Completer<ApiResponse<InformationData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.put, isPersonalInfo ? ApiRoutes.updatePersonalInformation:ApiRoutes.updateBusinessInformation,
          body: jsonEncode(details)
      );
      var result = ApiResponse<InformationData>.fromJson(
        response,
            (data) => InformationData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //resolve/add bank details
  Future<ApiResponse<BankAccount>> addBankAccount({required Map<String, dynamic> filterParams}) async {
    var completer = Completer<ApiResponse<BankAccount>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.addAccountDetails(filterParams: Utilities.returnQueryString(params: filterParams)),
      );
      var result = ApiResponse<BankAccount>.fromJson(
        response,
            (data) => BankAccount.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //delete bank account
  Future<ApiResponse> deleteBankAccount({required String? id, bool fromOnboarding = false}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.delete, ApiRoutes.deleteAccountDetails(id: id, fromOnboarding: fromOnboarding),
        useAuth: true,
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
  
  //set transaction pin
  Future<ApiResponse> setTransactionPin({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.setTransactionPin,
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