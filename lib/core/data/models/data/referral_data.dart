import 'package:winit_agent/core/data/models/data/pagination_data.dart';


import '../transaction.dart';

class ReferralData {
  final dynamic totalBalance;
  final dynamic lastPeriodBalance;
  final dynamic period;
  final PaginationData<Transaction>? referrals;

  ReferralData({
    this.totalBalance,
    this.lastPeriodBalance,
    this.period,
    this.referrals,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) => ReferralData(
    totalBalance: json["total_balance"],
    lastPeriodBalance: json["last_period_balance"],
    period: json["period"],
    referrals: json["referrals"] == null
        ? null
        : PaginationData<Transaction>.fromJson(
      json["referrals"],
          (x) => Transaction.fromJson(x),
    ),
  );

  Map<String, dynamic> toJson() => {
    "total_balance": totalBalance,
    "last_period_balance": lastPeriodBalance,
    "period": period,
    "referrals": referrals?.toJson((x) => x.toJson()),
  };
}