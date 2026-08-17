class AgentSettlementCardConfig {
  final bool? isEnabled;

  AgentSettlementCardConfig({
    this.isEnabled,
  });

  factory AgentSettlementCardConfig.fromJson(Map<String, dynamic> json) => AgentSettlementCardConfig(
    isEnabled: json["is_enabled"],
  );

  Map<String, dynamic> toJson() => {
    "is_enabled": isEnabled,
  };
}