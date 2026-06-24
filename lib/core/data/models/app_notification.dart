class AppNotification {
  final String? id;
  final String? type;
  final String? title;
  final String? message;
  final dynamic orderId;
  final dynamic readAt;
  final DateTime? createdAt;

  AppNotification({
    this.id,
    this.type,
    this.title,
    this.message,
    this.orderId,
    this.readAt,
    this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    message: json["message"],
    orderId: json["order_id"],
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "message": message,
    "order_id": orderId,
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
  };
}