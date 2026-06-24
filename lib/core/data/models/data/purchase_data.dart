import '../order.dart';
import '../ticket.dart';

class PurchaseData {
  final Order? order;
  final String? gameName;
  final String? gameCategoryName;
  final String? agentId;
  final List<Ticket>? tickets;
  final List<String>? ticketNumbers;

  PurchaseData({
    this.order,
    this.gameName,
    this.gameCategoryName,
    this.agentId,
    this.tickets,
    this.ticketNumbers,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    gameName: json["game_name"],
    gameCategoryName: json["game_category_name"],
    agentId: json["agentID"],
    tickets: json["tickets"] == null ? [] : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    ticketNumbers: json["ticket_numbers"] == null ? [] : List<String>.from(json["ticket_numbers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "game_name": gameName,
    "game_category_name": gameCategoryName,
    "agentID": agentId,
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "ticket_numbers": ticketNumbers == null ? [] : List<dynamic>.from(ticketNumbers!.map((x) => x)),
  };
}