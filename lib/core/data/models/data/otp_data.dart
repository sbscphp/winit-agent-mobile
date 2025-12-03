class OtpData {
  final String? masked;
  final String? userId;
  final String? identifier;
  final bool? returningUser;
  final String? minutes;
  final String? temporaryId;
  final String? phoneNumber;
  final bool? isVerified;
  final dynamic registrationStep;

  OtpData({
    this.masked,
    this.identifier,
    this.userId,
    this.minutes,
    this.temporaryId,
    this.returningUser,
    this.phoneNumber,
    this.isVerified,
    this.registrationStep
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    masked: json["masked"],
      identifier: json["identifier"],
      userId: json["user_id"],
    minutes: json["minutes"],
    temporaryId: json["temporary_id"],
    isVerified: json["is_verified"],
      returningUser: json["returning_user"],
      phoneNumber: json["phone_number"],
    registrationStep: json["registration_step"]
  );

  Map<String, dynamic> toJson() => {
    "masked": masked,
    "user_id": userId,
    "identifier": identifier,
    "minutes": minutes,
    "returning_user": returningUser,
    "phone_number": phoneNumber,
    "temporary_id": temporaryId,
    "is_verified": isVerified,
    "registration_step": registrationStep
  };
}