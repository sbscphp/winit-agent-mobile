class PaymentSummary {
  final dynamic quantity;
  final dynamic totalAmount;
  final dynamic gameTicketDiscount;
  final dynamic promoAmount;
  final dynamic promoCode;
  final dynamic promoCodeId;
  final dynamic discountAmount;
  final dynamic currentReferralBalance;
  final dynamic referralAmountUsed;
  final dynamic netReferralAmountBalance;
  final dynamic amountToPay;
  final dynamic spendLimitAmount;
  final dynamic spendLimitRemaining;
  final Commission? commission;

  PaymentSummary({
    this.quantity,
    this.totalAmount,
    this.gameTicketDiscount,
    this.promoAmount,
    this.promoCode,
    this.promoCodeId,
    this.discountAmount,
    this.currentReferralBalance,
    this.referralAmountUsed,
    this.netReferralAmountBalance,
    this.amountToPay,
    this.spendLimitAmount,
    this.spendLimitRemaining,
    this.commission,
  });

  factory PaymentSummary.fromJson(Map<String, dynamic> json) => PaymentSummary(
    quantity: json["quantity"],
    totalAmount: json["total_amount"],
    gameTicketDiscount: json["game_ticket_discount"],
    promoAmount: json["promo_amount"],
    promoCode: json["promo_code"],
    promoCodeId: json["promo_code_id"],
    discountAmount: json["discount_amount"],
    currentReferralBalance: json["current_referral_balance"],
    referralAmountUsed: json["referral_amount_used"],
    netReferralAmountBalance: json["net_referral_amount_balance"],
    amountToPay: json["amount_to_pay"],
    spendLimitAmount: json["spend_limit_amount"],
    spendLimitRemaining: json["spend_limit_remaining"],
    commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "total_amount": totalAmount,
    "game_ticket_discount": gameTicketDiscount,
    "promo_amount": promoAmount,
    "promo_code": promoCode,
    "promo_code_id": promoCodeId,
    "discount_amount": discountAmount,
    "current_referral_balance": currentReferralBalance,
    "referral_amount_used": referralAmountUsed,
    "net_referral_amount_balance": netReferralAmountBalance,
    "amount_to_pay": amountToPay,
    "spend_limit_amount": spendLimitAmount,
    "spend_limit_remaining": spendLimitRemaining,
    "commission": commission?.toJson(),
  };
}

class Commission {
  final dynamic commissionRate;
  final dynamic flatBonus;
  final dynamic grossCommissionAmount;
  final dynamic withholdingTaxPercentage;
  final dynamic withholdingTaxAmount;
  final dynamic netCommissionAmount;

  Commission({
    this.commissionRate,
    this.flatBonus,
    this.grossCommissionAmount,
    this.withholdingTaxPercentage,
    this.withholdingTaxAmount,
    this.netCommissionAmount,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
    commissionRate: json["commission_rate"],
    flatBonus: json["flat_bonus"],
    grossCommissionAmount: json["gross_commission_amount"],
    withholdingTaxPercentage: json["withholding_tax_percentage"],
    withholdingTaxAmount: json["withholding_tax_amount"],
    netCommissionAmount: json["net_commission_amount"],
  );

  Map<String, dynamic> toJson() => {
    "commission_rate": commissionRate,
    "flat_bonus": flatBonus,
    "gross_commission_amount": grossCommissionAmount,
    "withholding_tax_percentage": withholdingTaxPercentage,
    "withholding_tax_amount": withholdingTaxAmount,
    "net_commission_amount": netCommissionAmount,
  };
}