import 'package:winit_agent/core/data/models/tier.dart';

class Discount {
  final String? type;
  final dynamic value;
  final List<Tier>? tiers;

  Discount({
    this.type,
    this.value,
    this.tiers,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    type: json["type"],
    value: json["value"],
    tiers: json["tiers"] == null ? [] : List<Tier>.from(json["tiers"]!.map((x) => Tier.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
    "tiers": tiers == null ? [] : List<dynamic>.from(tiers!.map((x) => x.toJson())),
  };
}