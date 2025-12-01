class AccountClosureData {
  final String? status;
  final bool? canInitiateClosure;
  final DateTime? closedAt;
  final String? closureReason;
  final DateTime? reactivationRequestedAt;

  AccountClosureData({
    this.status,
    this.canInitiateClosure,
    this.closedAt,
    this.closureReason,
    this.reactivationRequestedAt,
  });

  factory AccountClosureData.fromJson(Map<String, dynamic> json) => AccountClosureData(
    status: json["status"],
    canInitiateClosure: json["can_initiate_closure"],
    closedAt: json["closed_at"] == null ? null : DateTime.parse(json["closed_at"]),
    closureReason: json["closure_reason"],
    reactivationRequestedAt: json["reactivation_requested_at"] == null ? null : DateTime.parse(json["reactivation_requested_at"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "can_initiate_closure": canInitiateClosure,
    "closed_at": closedAt?.toIso8601String(),
    "closure_reason": closureReason,
    "reactivation_requested_at": reactivationRequestedAt?.toIso8601String(),
  };
}