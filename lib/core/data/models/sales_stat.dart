class SalesStat {
  final dynamic totalSales;
  final dynamic totalTicketsSoldQuantity;
  final dynamic period;
  final dynamic ticketsLastPeriodSoldValue;
  final dynamic ticketsLastPeriodQuantity;
  final dynamic commissionsValue;
  final dynamic bonusValue;
  final dynamic commissionsPaidValue;
  final dynamic commissionsUnpaidValue;
  final dynamic commissionsLastPeriodValue;
  final dynamic commissionsLastPeriodPaidValue;
  final dynamic commissionsLastPeriodUnpaidValue;
  final dynamic rankPosition;
  final dynamic rankValue;
  final dynamic totalAgentsInRank;
  final String? rankBy;

  SalesStat({
    this.totalSales,
    this.totalTicketsSoldQuantity,
    this.period,
    this.ticketsLastPeriodSoldValue,
    this.ticketsLastPeriodQuantity,
    this.commissionsValue,
    this.bonusValue,
    this.commissionsPaidValue,
    this.commissionsUnpaidValue,
    this.commissionsLastPeriodValue,
    this.commissionsLastPeriodPaidValue,
    this.commissionsLastPeriodUnpaidValue,
    this.rankPosition,
    this.rankValue,
    this.totalAgentsInRank,
    this.rankBy,
  });

  factory SalesStat.fromJson(Map<String, dynamic> json) => SalesStat(
    totalSales: json["total_sales"],
    totalTicketsSoldQuantity: json["total_tickets_sold_quantity"],
    period: json["period"],
    ticketsLastPeriodSoldValue: json["tickets_last_period_sold_value"],
    ticketsLastPeriodQuantity: json["tickets_last_period_quantity"],
    commissionsValue: json["commissions_value"],
    bonusValue: json["bonus_value"],
    commissionsPaidValue: json["commissions_paid_value"],
    commissionsUnpaidValue: json["commissions_unpaid_value"],
    commissionsLastPeriodValue: json["commissions_last_period_value"],
    commissionsLastPeriodPaidValue: json["commissions_last_period_paid_value"],
    commissionsLastPeriodUnpaidValue: json["commissions_last_period_unpaid_value"],
    rankPosition: json["rank_position"],
    totalAgentsInRank: json["total_agents_in_rank"],
    rankBy: json["rank_by"],
    rankValue: json["rank_value"],
  );

  Map<String, dynamic> toJson() => {
    "total_sales": totalSales,
    "total_tickets_sold_quantity": totalTicketsSoldQuantity,
    "period": period,
    "tickets_last_period_sold_value": ticketsLastPeriodSoldValue,
    "tickets_last_period_quantity": ticketsLastPeriodQuantity,
    "commissions_value": commissionsValue,
    "commissions_paid_value": commissionsPaidValue,
    "commissions_unpaid_value": commissionsUnpaidValue,
    "commissions_last_period_value": commissionsLastPeriodValue,
    "commissions_last_period_paid_value": commissionsLastPeriodPaidValue,
    "commissions_last_period_unpaid_value": commissionsLastPeriodUnpaidValue,
    "rank_position": rankPosition,
    "total_agents_in_rank": totalAgentsInRank,
    "rank_by": rankBy,
    "rank_value": rankValue,
  };
}