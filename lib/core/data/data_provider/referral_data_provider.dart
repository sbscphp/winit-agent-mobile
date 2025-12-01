import 'dart:async';
import 'package:winit_agent/core/data/models/data/referral_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../network_manager/network_manager.dart';

class ReferralDataProvider{

  //fetch referral
  Future<ApiResponse<ReferralData>> fetchReferralHistory({required int? pageNumber}) async {
    var completer = Completer<ApiResponse<ReferralData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchReferralHistory(
          pageNumber: pageNumber,
      ),
          useAuth: true
      );
      var result = ApiResponse<ReferralData>.fromJson(
        response,
            (data) => ReferralData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}