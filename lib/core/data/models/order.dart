import 'package:winit_agent/core/data/models/ticket.dart';

import 'game.dart';

class Order {
  final String? uuid;
  final String? uniqueId;
  final String? customerId;
  final String? gameId;
  final String? platform;
  final dynamic merchant;
  final dynamic merchantId;
  final String? paymentMethod;
  final String? paymentType;
  final String? transactionId;
  final dynamic referralBalanceAmount;
  final int? earlyBird;
  final int? quantity;
  final dynamic totalAmount;
  final dynamic paidAmount;
  final dynamic discountAmount;
  final dynamic promoCode;
  final dynamic promoCodeId;
  final dynamic promoAmount;
  final dynamic referralCode;
  final String? status;
  final String? paymentStatus;
  final DateTime? createdAt;
  final int? ticketsCount;
  final DateTime? drawDate;
  final DateTime? gameEndDate;
  final List<Ticket>? tickets;
  final Game? game;

  Order({
    this.uuid,
    this.uniqueId,
    this.customerId,
    this.gameId,
    this.platform,
    this.merchant,
    this.merchantId,
    this.paymentMethod,
    this.paymentType,
    this.transactionId,
    this.referralBalanceAmount,
    this.earlyBird,
    this.quantity,
    this.totalAmount,
    this.paidAmount,
    this.discountAmount,
    this.promoCode,
    this.promoCodeId,
    this.promoAmount,
    this.referralCode,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.ticketsCount,
    this.drawDate,
    this.gameEndDate,
    this.tickets,
    this.game
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    uuid: json["uuid"],
    uniqueId: json["uniqueID"],
    customerId: json["customer_id"],
    gameId: json["game_id"],
    platform: json["platform"],
    merchant: json["merchant"],
    merchantId: json["merchant_id"],
    paymentMethod: json["payment_method"],
    paymentType: json["payment_type"],
    transactionId: json["transaction_id"],
    referralBalanceAmount: json["referral_balance_amount"],
    earlyBird: json["early_bird"],
    quantity: json["quantity"],
    totalAmount: json["total_amount"],
    paidAmount: json["paid_amount"],
    discountAmount: json["discount_amount"],
    promoCode: json["promo_code"],
    promoCodeId: json["promo_code_id"],
    promoAmount: json["promo_amount"],
    referralCode: json["referral_code"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    ticketsCount: json["tickets_count"],
    drawDate: json["draw_date"] == null ? null : DateTime.parse(json["draw_date"]),
    gameEndDate: json["game_end_date"] == null ? null : DateTime.parse(json["game_end_date"]),
    tickets: json["tickets"] == null ? [] : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    game: json["game"] == null ? null : Game.fromJson(json["discount"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uniqueID": uniqueId,
    "customer_id": customerId,
    "game_id": gameId,
    "platform": platform,
    "merchant": merchant,
    "merchant_id": merchantId,
    "payment_method": paymentMethod,
    "payment_type": paymentType,
    "transaction_id": transactionId,
    "referral_balance_amount": referralBalanceAmount,
    "early_bird": earlyBird,
    "quantity": quantity,
    "total_amount": totalAmount,
    "paid_amount": paidAmount,
    "discount_amount": discountAmount,
    "promo_code": promoCode,
    "promo_code_id": promoCodeId,
    "promo_amount": promoAmount,
    "referral_code": referralCode,
    "status": status,
    "payment_status": paymentStatus,
    "created_at": createdAt?.toIso8601String(),
    "tickets_count": ticketsCount,
    "draw_date": drawDate?.toIso8601String(),
    "game_end_date": gameEndDate?.toIso8601String(),
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
  };
}