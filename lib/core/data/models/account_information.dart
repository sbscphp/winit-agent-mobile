import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/models/platform_account.dart';

class AccountInformation {
  final PlatformAccount? platformAccount;
  final List<BankAccount>? bankInformation;

  AccountInformation({
    this.platformAccount,
    this.bankInformation,
  });

  factory AccountInformation.fromJson(Map<String, dynamic> json) => AccountInformation(
    platformAccount: json["platform_account"] == null ? null : PlatformAccount.fromJson(json["platform_account"]),
    bankInformation: json["bank_information"] == null ? [] : List<BankAccount>.from(json["bank_information"]!.map((x) => BankAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "platform_account": platformAccount?.toJson(),
    "bank_information": bankInformation == null ? [] : List<dynamic>.from(bankInformation!.map((x) => x.toJson())),
  };
}