import 'package:winit_agent/core/data/models/draw.dart';

class Ticket {
  final int? number;
  final dynamic originalPrice;
  final dynamic discountPrice;
  final String? uuid;
  final String? orderId;
  final String? customerId;
  final String? ticketNumber;
  final String? validationNumber;
  final DateTime? issuedAt;
  final int? isWinner;
  final int? isWinnerEarlyBird;
  final DateTime? createdAt;
  final Draws? draws;
  final bool? bestValue;

  Ticket({
    this.number,
    this.originalPrice,
    this.discountPrice,
    this.uuid,
    this.orderId,
    this.customerId,
    this.ticketNumber,
    this.validationNumber,
    this.issuedAt,
    this.isWinner,
    this.isWinnerEarlyBird,
    this.createdAt,
    this.draws,
    this.bestValue
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    number: json["number"],
    bestValue: json["best_value"],
    originalPrice: json["original_price"],
    discountPrice: json["discount_price"],
    uuid: json["uuid"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    ticketNumber: json["ticket_number"],
    validationNumber: json["validation_number"],
    issuedAt: DateTime.tryParse(json["issued_at"] ?? ""),
    isWinner: json["is_winner"],
    isWinnerEarlyBird: json["is_winner_early_bird"],
    createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    draws: json["draws"] == null ? null : Draws.fromJson(json["draws"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "best_value": bestValue,
    "original_price": originalPrice,
    "discount_price": discountPrice,
    "uuid": uuid,
    "order_id": orderId,
    "customer_id": customerId,
    "ticket_number": ticketNumber,
    "validation_number": validationNumber,
    "issued_at": issuedAt?.toIso8601String(),
    "is_winner": isWinner,
    "is_winner_early_bird": isWinnerEarlyBird,
    "created_at": createdAt?.toIso8601String(),
    "draws": draws?.toJson(),
  };
}

class Draws {
  final Draw? mainDraw;
  final Draw? earlyBirdDraw;

  Draws({
    this.mainDraw,
    this.earlyBirdDraw,
  });

  factory Draws.fromJson(Map<String, dynamic> json) => Draws(
    mainDraw: json["main_draw"] == null ? null : Draw.fromJson(json["main_draw"]),
    earlyBirdDraw: json["early_bird_draw"] == null ? null : Draw.fromJson(json["early_bird_draw"]),
  );

  Map<String, dynamic> toJson() => {
    "main_draw": mainDraw?.toJson(),
    "early_bird_draw": earlyBirdDraw?.toJson(),
  };
}