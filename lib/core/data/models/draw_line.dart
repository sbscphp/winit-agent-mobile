class DrawLine {
  final String? uuid;
  final String? gameDrawId;
  final dynamic adminId;
  final dynamic customerId;
  final dynamic drawAt;
  final String? status;
  final DateTime? createdAt;
  final String? laravelThroughKey;

  DrawLine({
    this.uuid,
    this.gameDrawId,
    this.adminId,
    this.customerId,
    this.drawAt,
    this.status,
    this.createdAt,
    this.laravelThroughKey,
  });

  factory DrawLine.fromJson(Map<String, dynamic> json) => DrawLine(
    uuid: json["uuid"],
    gameDrawId: json["game_draw_id"],
    adminId: json["admin_id"],
    customerId: json["customer_id"],
    drawAt: json["draw_at"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "game_draw_id": gameDrawId,
    "admin_id": adminId,
    "customer_id": customerId,
    "draw_at": drawAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "laravel_through_key": laravelThroughKey,
  };
}