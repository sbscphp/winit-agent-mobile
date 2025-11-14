import 'package:winit_agent/core/data/models/prize_specification.dart';

class Prize {
  final String? uuid;
  final String? name;
  final int? quantity;
  final String? category;
  final dynamic unitPriceValue;
  final String? type;
  final dynamic endDate;
  final dynamic endTime;
  final String? status;
  final int? unitsWon;
  final dynamic context;
  final String? heading;
  final String? description;
  final String? supportingText;
  final String? gallery;
  final String? banner;
  final String? isActive;
  final String? categoryId;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<PrizeSpecification>? specifications;
  final bool? topPrize;

  Prize({
    this.uuid,
    this.name,
    this.quantity,
    this.category,
    this.unitPriceValue,
    this.type,
    this.endDate,
    this.endTime,
    this.status,
    this.unitsWon,
    this.context,
    this.heading,
    this.description,
    this.supportingText,
    this.gallery,
    this.banner,
    this.isActive,
    this.categoryId,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.specifications,
    this.topPrize
  });

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
    uuid: json["uuid"],
    topPrize: json["top_prize"],
    name: json["name"],
    quantity: json["quantity"],
    category: json["category"],
    unitPriceValue: json["unit_price_value"],
    type: json["type"],
    endDate: json["end_date"],
    endTime: json["end_time"],
    status: json["status"],
    unitsWon: json["units_won"],
    context: json["context"],
    heading: json["heading"],
    description: json["description"],
    supportingText: json["supporting_text"],
    gallery: json["gallery"],
    banner: json["banner"],
    isActive: json["is_active"],
    categoryId: json["category_id"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    specifications: json["specifications"] == null ? [] : List<PrizeSpecification>.from(json["specifications"]!.map((x) => PrizeSpecification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "top_prize": topPrize,
    "name": name,
    "quantity": quantity,
    "category": category,
    "unit_price_value": unitPriceValue,
    "type": type,
    "end_date": endDate,
    "end_time": endTime,
    "status": status,
    "units_won": unitsWon,
    "context": context,
    "heading": heading,
    "description": description,
    "supporting_text": supportingText,
    "gallery": gallery,
    "banner": banner,
    "is_active": isActive,
    "category_id": categoryId,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "specifications": specifications == null ? [] : List<dynamic>.from(specifications!.map((x) => x.toJson())),
  };
}