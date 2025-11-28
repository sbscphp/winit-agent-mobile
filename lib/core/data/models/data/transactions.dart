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
  };
}
