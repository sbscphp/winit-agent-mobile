import 'package:winit_agent/core/data/models/user.dart';

class IdentityResultData {
  final bool? isMatch;
  final String? matchStatus;
  final FieldMatches? fieldMatches;
  final String? verificationStatus;
  final String? bvn;
  final DateTime? verifiedAt;
  final User? returnedData;
  final User? ninDetails;
  final bool? savedToDb;

  IdentityResultData({
    this.isMatch,
    this.matchStatus,
    this.fieldMatches,
    this.verificationStatus,
    this.bvn,
    this.verifiedAt,
    this.returnedData,
    this.ninDetails,
    this.savedToDb,
  });

  factory IdentityResultData.fromJson(Map<String, dynamic> json) => IdentityResultData(
    isMatch: json["is_match"],
    matchStatus: json["match_status"],
    fieldMatches: json["field_matches"] == null ? null : FieldMatches.fromJson(json["field_matches"]),
    verificationStatus: json["verification_status"],
    bvn: json["bvn"],
    verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
    returnedData: json["returned_data"] == null ? null : User.fromJson(json["returned_data"]),
    ninDetails: json["nin_details"] == null ? null : User.fromJson(json["nin_details"]),
    savedToDb: json["saved_to_db"],
  );

  Map<String, dynamic> toJson() => {
    "is_match": isMatch,
    "match_status": matchStatus,
    "field_matches": fieldMatches?.toJson(),
    "verification_status": verificationStatus,
    "bvn": bvn,
    "verified_at": verifiedAt?.toIso8601String(),
    "returned_data": returnedData?.toJson(),
    "nin_details": ninDetails?.toJson(),
    "saved_to_db": savedToDb,
  };
}

class FieldMatches {
  final bool? firstname;
  final bool? lastname;
  final bool? gender;
  final bool? emailAddress;
  final bool? birthdate;
  final bool? phone;

  FieldMatches({
    this.firstname,
    this.lastname,
    this.gender,
    this.emailAddress,
    this.birthdate,
    this.phone,
  });

  factory FieldMatches.fromJson(Map<String, dynamic> json) => FieldMatches(
    firstname: json["firstname"],
    lastname: json["lastname"],
    gender: json["gender"],
    emailAddress: json["emailAddress"],
    birthdate: json["birthdate"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "gender": gender,
    "emailAddress": emailAddress,
    "birthdate": birthdate,
    "phone": phone,
  };
}