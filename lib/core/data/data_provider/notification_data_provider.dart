import 'dart:async';
import 'dart:convert';

import 'package:winit_agent/core/data/models/data/notification_data.dart';
import 'package:winit_agent/core/data/models/notification_preference.dart';
import 'package:winit_agent/core/data/models/transaction.dart';
import 'package:winit_agent/core/data/models/platform_account.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/data/pagination_data.dart';
import '../network_manager/network_manager.dart';

class NotificationDataProvider{



  //fetch notifications
  Future<ApiResponse<NotificationData>> fetchNotifications({required int? pageNumber, String? filterParams}) async {
    var completer = Completer<ApiResponse<NotificationData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchNotifications(
        pageNumber: pageNumber,
        filterParams: filterParams,
      ),
          useAuth: true
      );
      var result = ApiResponse<NotificationData>.fromJson(
        response,
            (data) => NotificationData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch notification settings
  Future<ApiResponse<NotificationPreference>> fetchNotificationSettings() async {
    var completer = Completer<ApiResponse<NotificationPreference>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchNotificationSettings,
          useAuth: true
      );
      var result = ApiResponse<NotificationPreference>.fromJson(
        response,
            (data) => NotificationPreference.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //update notification preference
  Future<ApiResponse<NotificationPreference>> updateNotificationSettings({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<NotificationPreference>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.put, ApiRoutes.updateNotificationSettings,
          useAuth: true,
        body: jsonEncode(details)
      );
      var result = ApiResponse<NotificationPreference>.fromJson(
        response,
            (data) => NotificationPreference.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}