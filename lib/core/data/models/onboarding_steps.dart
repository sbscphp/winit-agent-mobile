class OnboardingSteps {
  final String? registrationStep;
  final String? registrationStepStatus;
  //final String? registrationHistory;
  final DateTime? registrationStepUpdatedAt;
  final bool? ninVerification;
  final bool? bvnVerification;
  final bool? personalInformation;
  final bool? businessInformation;
  final bool? documentVerification;
  final bool? bankInformation;
  final bool? verificationCompleted;
  final bool? transactionPin;

  OnboardingSteps({
    this.registrationStep,
    this.registrationStepStatus,
    //this.registrationHistory,
    this.registrationStepUpdatedAt,
    this.ninVerification,
    this.bvnVerification,
    this.personalInformation,
    this.businessInformation,
    this.documentVerification,
    this.bankInformation,
    this.verificationCompleted,
    this.transactionPin,
  });

  factory OnboardingSteps.fromJson(Map<String, dynamic> json) => OnboardingSteps(
    registrationStep: json["registration_step"],
    registrationStepStatus: json["registration_step_status"],
    //registrationHistory: json["registration_history"],
    registrationStepUpdatedAt: json["registration_step_updated_at"] == null ? null : DateTime.parse(json["registration_step_updated_at"]),
    ninVerification: json["nin_verification"],
    bvnVerification: json["bvn_verification"],
    personalInformation: json["personal_information"],
    businessInformation: json["business_information"],
    documentVerification: json["document_verification"],
    bankInformation: json["bank_information"],
    verificationCompleted: json["verification_completed"],
    transactionPin: json["transaction_pin"],
  );

  Map<String, dynamic> toJson() => {
    "registration_step": registrationStep,
    "registration_step_status": registrationStepStatus,
    //"registration_history": registrationHistory,
    "registration_step_updated_at": registrationStepUpdatedAt?.toIso8601String(),
    "nin_verification": ninVerification,
    "bvn_verification": bvnVerification,
    "personal_information": personalInformation,
    "business_information": businessInformation,
    "document_verification": documentVerification,
    "bank_information": bankInformation,
    "verification_completed": verificationCompleted,
    "transaction_pin": transactionPin,
  };
}