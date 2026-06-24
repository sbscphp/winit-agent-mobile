class ServiceAgent {
  final String? name;
  final String? type;

  ServiceAgent({
    this.name,
    this.type,
  });

  factory ServiceAgent.fromJson(Map<String, dynamic> json) => ServiceAgent(
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
  };
}