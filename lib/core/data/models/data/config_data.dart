import 'package:winit_agent/core/data/models/frontend_links_configuration.dart';
import 'package:winit_agent/core/data/models/registration_configuration.dart';

import '../agent_settlement_card_config.dart';
import '../agent_wallet_policy_config.dart';




class ConfigData {
  final RegistrationConfiguration? registrationConfiguration;
  final FrontendLinksConfiguration? frontendLinksConfiguration;
  final AgentWalletPolicyConfig? agentWalletPolicyConfig;
  final AgentSettlementCardConfig? agentSettlementCardConfig;


  ConfigData({
    this.registrationConfiguration,
    this.frontendLinksConfiguration,
    this.agentWalletPolicyConfig,
    this.agentSettlementCardConfig
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
    registrationConfiguration: json["registration_configuration"] == null ? null : RegistrationConfiguration.fromJson(json["registration_configuration"]),
    frontendLinksConfiguration: json["frontend_links_configuration"] == null ? null : FrontendLinksConfiguration.fromJson(json["frontend_links_configuration"]),
    agentWalletPolicyConfig: json["agency_wallet_policy_configuration"] == null ? null : AgentWalletPolicyConfig.fromJson(json["agency_wallet_policy_configuration"]),
    agentSettlementCardConfig: json["agent_settlement_card_configuration"] == null ? null : AgentSettlementCardConfig.fromJson(json["agent_settlement_card_configuration"]),
  );

  Map<String, dynamic> toJson() => {
    "registration_configuration": registrationConfiguration?.toJson(),
    "frontend_links_configuration": frontendLinksConfiguration?.toJson(),
    "agency_wallet_policy_configuration": agentWalletPolicyConfig?.toJson(),
    "agent_settlement_card_configuration": agentSettlementCardConfig?.toJson(),
  };
}
