import '../service_agent.dart';

class ServiceAgentData {
  final List<ServiceAgent>? posAgent;
  final List<ServiceAgent>? financialAgent;

  ServiceAgentData({
    this.posAgent,
    this.financialAgent,
  });

  factory ServiceAgentData.fromJson(Map<String, dynamic> json) => ServiceAgentData(
    posAgent: json["pos_agent"] == null ? [] : List<ServiceAgent>.from(json["pos_agent"]!.map((x) => ServiceAgent.fromJson(x))),
    financialAgent: json["financial_agent"] == null ? [] : List<ServiceAgent>.from(json["financial_agent"]!.map((x) => ServiceAgent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pos_agent": posAgent == null ? [] : List<dynamic>.from(posAgent!.map((x) => x.toJson())),
    "financial_agent": financialAgent == null ? [] : List<dynamic>.from(financialAgent!.map((x) => x.toJson())),
  };
}