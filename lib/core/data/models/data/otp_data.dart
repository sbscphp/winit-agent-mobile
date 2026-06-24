class OtpData {
  final String? masked;
  final String? resetFlowId;
  final String? identifier;
  final bool? returningUser;
  final dynamic minutes;
  final String? temporaryId;
  final String? phoneNumber;
  final bool? isVerified;
  final dynamic registrationStep;

  OtpData({
    this.masked,
    this.identifier,
    this.resetFlowId,
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
      resetFlowId: json["reset_flow_id"],
    minutes: json["minutes"],
    temporaryId: json["temporary_id"],
    isVerified: json["is_verified"],
      returningUser: json["returning_user"],
      phoneNumber: json["phone_number"],
    registrationStep: json["registration_step"]
  );

  Map<String, dynamic> toJson() => {
    "masked": masked,
    "reset_flow_id": resetFlowId,
    "identifier": identifier,
    "minutes": minutes,
    "returning_user": returningUser,
    "phone_number": phoneNumber,
    "temporary_id": temporaryId,
    "is_verified": isVerified,
    "registration_step": registrationStep
  };
}