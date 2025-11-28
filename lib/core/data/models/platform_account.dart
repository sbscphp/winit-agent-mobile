import 'bank_account.dart';

class PlatformAccount {
  final dynamic inAppBalance;
  final dynamic accountBalance;
  final dynamic lastPeriodDaysBalance;
  final dynamic lastPeriodDays;
  final BankAccount? accountDetails;

  PlatformAccount({
    this.inAppBalance,
    this.accountBalance,
    this.lastPeriodDaysBalance,
    this.lastPeriodDays,
    this.accountDetails,
  });

  factory PlatformAccount.fromJson(Map<String, dynamic> json) => PlatformAccount(
    inAppBalance: json["in_app_balance"],
    accountBalance: json["account_balance"],
    lastPeriodDaysBalance: json["last_period_days_balance"],
    lastPeriodDays: json["last_period_days"],
    accountDetails: json["account_details"] == null ? null : BankAccount.fromJson(json["account_details"]),
  );

  Map<String, dynamic> toJson() => {
    "in_app_balance": inAppBalance,
    "account_balance": accountBalance,
    "last_period_days_balance": lastPeriodDaysBalance,
    "last_period_days": lastPeriodDays,
    "account_details": accountDetails?.toJson(),
  };
}