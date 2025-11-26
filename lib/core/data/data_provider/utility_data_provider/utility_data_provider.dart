
import 'dart:async';
import 'package:winit_agent/core/data/models/bank.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/models/data/service_agent_data.dart';
import 'package:winit_agent/core/data/models/lga_details.dart';
import '../../../constants/api_routes.dart';
import '../../../utilities/utilities.dart';
import '../../enum/request_type.dart';
import '../../models/api_response.dart';
import '../../network_manager/network_manager.dart';

class UtilityDataProvider{

  //fetch lga details
  Future<ApiResponse<List<LgaDetails>>> fetchLgaDetails() async {
    var completer = Completer<ApiResponse<List<LgaDetails>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchLgaDetails,
      );
      var result = ApiResponse<List<LgaDetails>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => LgaDetails.fromJson(
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

  //fetch service agent providers
  Future<ApiResponse<ServiceAgentData>> fetchAgentProviders() async {
    var completer = Completer<ApiResponse<ServiceAgentData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchServiceAgents,
      );
      var result = ApiResponse<ServiceAgentData>.fromJson(
        response,
            (data) => ServiceAgentData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch banks
  Future<ApiResponse<List<Bank>>> fetchBanks() async {
    var completer = Completer<ApiResponse<List<Bank>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchBanks,
      );
      var result = ApiResponse<List<Bank>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => Bank.fromJson(
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

  //fetch terms
  Future<ApiResponse<String>> fetchTerms() async {
    var completer = Completer<ApiResponse<String>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchTerms,
      );
      var result = ApiResponse<String>.fromJson(
        response,
            (data) => data as String,
      );

      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}