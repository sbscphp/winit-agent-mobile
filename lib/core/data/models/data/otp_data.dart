class OtpData {
  final String? masked;
  final String? minutes;
  final String? temporaryId;
  final bool? isVerified;
  final dynamic registrationStep;

  OtpData({
    this.masked,
    this.minutes,
    this.temporaryId,
    this.isVerified,
    this.registrationStep
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    masked: json["masked"],
    minutes: json["minutes"],
    temporaryId: json["temporary_id"],
    isVerified: json["is_verified"],
    registrationStep: json["registration_step"]
  );

  Map<String, dynamic> toJson() => {
    "masked": masked,
    "minutes": minutes,
    "temporary_id": temporaryId,
    "is_verified": isVerified,
    "registration_step": registrationStep
  };
}