import 'package:winit_agent/core/data/models/prize.dart';

class Draw {
  final DateTime? endDate;
  final String? overview;
  final String? otherDetails;
  final List<Prize>? prizes;
  final String? status;
  final String? prize;
  final String? category;
  final String? type;
  final String? drawStatus;

  Draw({
    this.endDate,
    this.overview,
    this.otherDetails,
    this.prizes,
    this.status,
    this.prize,
    this.category,
    this.type,
    this.drawStatus,
  });

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    overview: json["overview"],
    otherDetails: json["other_details"],
    prizes: json["prizes"] == null ? [] : List<Prize>.from(json["prizes"]!.map((x) => Prize.fromJson(x))),
    status: json["status"],
    prize: json["prize"],
    category: json["category"],
    type: json["type"],
    drawStatus: json["draw_status"],
  );

  Map<String, dynamic> toJson() => {
    "end_date": endDate?.toIso8601String(),
    "overview": overview,
    "other_details": otherDetails,
    "prizes": prizes == null ? [] : List<dynamic>.from(prizes!.map((x) => x.toJson())),
    "status": status,
    "prize": prize,
    "category": category,
    "type": type,
    "draw_status": drawStatus,
  };
}