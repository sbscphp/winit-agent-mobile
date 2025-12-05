class NotificationPreference {
  final String? agentId;
  final String? general;
  final String? games;
  final String? ticketPurchases;
  final String? wallet;
  final String? commissionDisbursements;
  final String? bonusDisbursements;
  final String? referrals;
  final String? uuid;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  NotificationPreference({
    this.agentId,
    this.general,
    this.games,
    this.ticketPurchases,
    this.wallet,
    this.commissionDisbursements,
    this.bonusDisbursements,
    this.referrals,
    this.uuid,
    this.updatedAt,
    this.createdAt,
  });

  factory NotificationPreference.fromJson(Map<String, dynamic> json) => NotificationPreference(
    agentId: json["agent_id"],
    general: json["general"],
    games: json["games"],
    ticketPurchases: json["ticket_purchases"],
    wallet: json["wallet"],
    commissionDisbursements: json["commission_disbursements"],
    bonusDisbursements: json["bonus_disbursements"],
    referrals: json["referrals"],
    uuid: json["uuid"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "agent_id": agentId,
    "general": general,
    "games": games,
    "ticket_purchases": ticketPurchases,
    "wallet": wallet,
    "commission_disbursements": commissionDisbursements,
    "bonus_disbursements": bonusDisbursements,
    "referrals": referrals,
    "uuid": uuid,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}