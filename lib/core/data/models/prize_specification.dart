class PrizeSpecification {
  final String? uuid;
  final String? specification;
  final String? icon;
  final String? info;
  final String? prizeId;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  PrizeSpecification({
    this.uuid,
    this.specification,
    this.icon,
    this.info,
    this.prizeId,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PrizeSpecification.fromJson(Map<String, dynamic> json) => PrizeSpecification(
    uuid: json["uuid"],
    specification: json["specification"],
    icon: json["icon"],
    info: json["info"],
    prizeId: json["prize_id"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "specification": specification,
    "icon": icon,
    "info": info,
    "prize_id": prizeId,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}