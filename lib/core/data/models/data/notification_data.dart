import 'package:winit_agent/core/data/models/app_notification.dart';
import 'package:winit_agent/core/data/models/data/pagination_data.dart';

class NotificationData {
  final PaginationData<AppNotification>? notifications;

  NotificationData({
    this.notifications,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notifications: json["notifications"] == null
        ? null
        : PaginationData<AppNotification>.fromJson(
      json["notifications"],
          (x) => AppNotification.fromJson(x),
    ),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications?.toJson((x) => x.toJson()),
  };
}