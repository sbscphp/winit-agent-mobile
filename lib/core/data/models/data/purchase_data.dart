import '../order.dart';

class PurchaseData {
  final Order? order;
  final List<String>? tickets;

  PurchaseData({
    this.order,
    this.tickets,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    tickets: json["tickets"] == null ? [] : List<String>.from(json["tickets"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x)),
  };
}