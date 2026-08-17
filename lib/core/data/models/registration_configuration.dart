class RegistrationConfiguration {
  final bool? verifyEmailOtp;
  final bool? useLga;
  final bool? useLgaArea;

  RegistrationConfiguration({
    this.verifyEmailOtp,
    this.useLga,
    this.useLgaArea,
  });

  factory RegistrationConfiguration.fromJson(Map<String, dynamic> json) => RegistrationConfiguration(
    verifyEmailOtp: json["verify_email_otp"],
    useLga: json["use_lga"],
    useLgaArea: json["use_lga_area"],
  );

  Map<String, dynamic> toJson() => {
    "verify_email_otp": verifyEmailOtp,
    "use_lga": useLga,
    "use_lga_area": useLgaArea,
  };
}