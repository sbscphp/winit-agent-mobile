class BankAccount {
  final String? uuid;
  final String? bankName;
  final String? accountNumber;
  final String? accountName;
  final String? accountBank;
  final String? uniqueID;
  final String? isActive;
  final String? isDefault;
  final DateTime? createdAt;

  BankAccount({
    this.uuid,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.accountBank,
    this.isActive,
    this.uniqueID,
    this.isDefault,
    this.createdAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    uuid: json["uuid"],
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    accountBank: json["account_bank"],
    uniqueID: json["uniqueID"],
    isActive: json["is_active"],
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "bank_name": bankName,
    "account_number": accountNumber,
    "uniqueID": uniqueID,
    "account_name": accountName,
    "account_bank": accountBank,
    "is_active": isActive,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
  };
}