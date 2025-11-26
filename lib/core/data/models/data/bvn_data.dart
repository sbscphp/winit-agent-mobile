class BvnData {
  final bool? isMatch;
  // final String? matchStatus;
  // final List<dynamic>? fieldMatches;
  // final String? verificationStatus;
  // final String? bvn;
  // final DateTime? verifiedAt;

  BvnData({
    this.isMatch,
    // this.matchStatus,
    // this.fieldMatches,
    // this.verificationStatus,
    // this.bvn,
    // this.verifiedAt,
  });

  factory BvnData.fromJson(Map<String, dynamic> json) => BvnData(
    isMatch: json["is_match"],
    // matchStatus: json["match_status"],
    // fieldMatches: json["field_matches"] == null ? [] : List<dynamic>.from(json["field_matches"]!.map((x) => x)),
    // verificationStatus: json["verification_status"],
    // bvn: json["bvn"],
    // verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "is_match": isMatch,
    // "match_status": matchStatus,
    // "field_matches": fieldMatches == null ? [] : List<dynamic>.from(fieldMatches!.map((x) => x)),
    // "verification_status": verificationStatus,
    // "bvn": bvn,
    // "verified_at": verifiedAt?.toIso8601String(),
  };
}