class AgentWalletPolicyConfig {
  final bool? agentAccountEnabled;

  AgentWalletPolicyConfig({
    this.agentAccountEnabled,
  });

  factory AgentWalletPolicyConfig.fromJson(Map<String, dynamic> json) => AgentWalletPolicyConfig(
    agentAccountEnabled: json["agent_account_enabled"],
  );

  Map<String, dynamic> toJson() => {
    "agent_account_enabled": agentAccountEnabled,
  };
}