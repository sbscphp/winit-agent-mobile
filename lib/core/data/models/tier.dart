class Tier {
  final int? min;
  final int? max;
  final dynamic value;

  Tier({
    this.min,
    this.max,
    this.value,
  });

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
    min: json["min"],
    max: json["max"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "value": value,
  };
}