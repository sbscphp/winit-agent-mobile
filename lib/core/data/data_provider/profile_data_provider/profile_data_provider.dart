
import 'dart:async';
import 'dart:convert';

import 'package:winit_agent/core/data/models/data/information_data.dart';

import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/api_response.dart';
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
}