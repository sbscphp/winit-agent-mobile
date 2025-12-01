import 'package:winit_agent/core/data/models/user.dart';

class Transaction {
  final String? uuid;
  final String? agentId;
  final String? bankAccountId;
  final String? type;
  final dynamic amount;
  final String? description;
  final String? reference;
  final String? status;
  final dynamic metadata;
  final DateTime? createdAt;
  //referral
  final User? user;
  final String? mainStatus;
  final String? reason;
  final DateTime? dateReferred;
  final dynamic rewardAmount;

  Transaction({
    this.uuid,
    this.agentId,
    this.bankAccountId,
    this.type,
    this.amount,
    this.description,
    this.reference,
    this.status,
    this.metadata,
    this.createdAt,

    //referral
    this.user,
    this.mainStatus,
    this.reason,
    this.dateReferred,
    this.rewardAmount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    uuid: json["uuid"],
    agentId: json["agent_id"],
    bankAccountId: json["bank_account_id"],
    type: json["type"],
    amount: json["amount"],
    description: json["description"],
    reference: json["reference"],
    status: json["status"],
    metadata: json["metadata"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),

    //referral
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    mainStatus: json["main_status"],
    reason: json["reason"],
    dateReferred: json["date_referred"] == null ? null : DateTime.parse(json["date_referred"]),
    rewardAmount: json["reward_amount"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "agent_id": agentId,
    "bank_account_id": bankAccountId,
    "type": type,
    "amount": amount,
    "description": description,
    "reference": reference,
    "status": status,
    "metadata": metadata,
    "created_at": createdAt?.toIso8601String(),

    //referral
    "user": user?.toJson(),
    "main_status": mainStatus,
    "reason": reason,
    "date_referred": dateReferred?.toIso8601String(),
    "reward_amount": rewardAmount,
  };
}
