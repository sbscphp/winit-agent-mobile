import 'package:winit_agent/core/data/models/discount.dart';
import 'package:winit_agent/core/data/models/draw.dart';
import 'package:winit_agent/core/data/models/draw_line.dart';
import 'package:winit_agent/core/data/models/sponsor.dart';
import 'package:winit_agent/core/data/models/ticket.dart';

import 'color_theme.dart';

class Game {
  final String? uuid;
  final String? name;
  final String? categoryName;
  final String? uniqueId;
  final dynamic ticketPrice;
  final String? description;
  final String? longDescription;
  final String? ctaText;
  final String? details;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? howToPlay;
  final String? status;
  final List<Ticket>? tickets;
  final ColorTheme? colorThemes;
  final Discount? discount;
  final Prizes? prizes;
  final List<Sponsor>? sponsors;
  final List<DrawLine>? drawLines;
  final dynamic minimumTicketNumberPurchase;
  final dynamic maximumTicketAmountPurchase;
  final String? usePromoCode;
  final String? useReferralAmount;
  final DateTime? createdAt;
  final String? ticketTip;



  Game({
    this.uuid,
    this.name,
    this.uniqueId,
    this.ticketPrice,
    this.description,
    this.categoryName,
    this.longDescription,
    this.ctaText,
    this.details,
    this.startDate,
    this.endDate,
    this.howToPlay,
    this.status,
    this.tickets,
    this.colorThemes,
    this.discount,
    this.prizes,
    this.sponsors,
    this.drawLines,
    this.minimumTicketNumberPurchase,
    this.maximumTicketAmountPurchase,
    this.usePromoCode,
    this.useReferralAmount,
    this.createdAt,
    this.ticketTip
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    uuid: json["uuid"],
    ticketTip: json["ticket_tip"],
    name: json["name"],
    categoryName: json["category_name"],
    uniqueId: json["uniqueID"],
    ticketPrice: json["ticket_price"],
    description: json["description"],
    longDescription: json["long_description"],
    ctaText: json["cta_text"],
    details: json["details"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    howToPlay: json["how_to_play"],
    status: json["status"],
    tickets: json["tickets"] == null ? [] : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    colorThemes: json["color_themes"] == null ? null : ColorTheme.fromJson(json["color_themes"]),
    discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    prizes: json["prizes"] == null ? null : Prizes.fromJson(json["prizes"]),
    sponsors: json["sponsors"] == null ? [] : List<Sponsor>.from(json["sponsors"]!.map((x) => Sponsor.fromJson(x))),
    drawLines: json["draw_lines"] == null ? [] : List<DrawLine>.from(json["draw_lines"]!.map((x) => DrawLine.fromJson(x))),
    minimumTicketNumberPurchase: json["minimum_ticket_number_purchase"],
    maximumTicketAmountPurchase: json["maximum_ticket_amount_purchase"],
    usePromoCode: json["use_promo_code"],
    useReferralAmount: json["use_referral_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "category_name": categoryName,
    "ticket_tip": ticketTip,
    "uniqueID": uniqueId,
    "ticket_price": ticketPrice,
    "description": description,
    "long_description": longDescription,
    "cta_text": ctaText,
    "details": details,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "how_to_play": howToPlay,
    "status": status,
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "color_themes": colorThemes?.toJson(),
    "discount": discount?.toJson(),
    "prizes": prizes?.toJson(),
    "sponsors": sponsors == null ? [] : List<dynamic>.from(sponsors!.map((x) => x.toJson())),
    "draw_lines": drawLines == null ? [] : List<dynamic>.from(drawLines!.map((x) => x.toJson())),
    "minimum_ticket_number_purchase": minimumTicketNumberPurchase,
    "maximum_ticket_amount_purchase": maximumTicketAmountPurchase,
    "use_promo_code": usePromoCode,
    "use_referral_amount": useReferralAmount,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Prizes {
  final Draw? mainDraw;
  final Draw? earlyDraw;

  Prizes({
    this.mainDraw,
    this.earlyDraw,
  });

  factory Prizes.fromJson(Map<String, dynamic> json) => Prizes(
    mainDraw: json["main_draw"] == null ? null : Draw.fromJson(json["main_draw"]),
    earlyDraw: json["early_draw"] == null ? null : Draw.fromJson(json["early_draw"]),
  );

  Map<String, dynamic> toJson() => {
    "main_draw": mainDraw?.toJson(),
    "early_draw": earlyDraw?.toJson(),
  };
}