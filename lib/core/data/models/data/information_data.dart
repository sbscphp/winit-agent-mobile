
import 'package:winit_agent/core/data/models/onboarding_steps.dart';

import '../business_information.dart';
import '../user.dart';

class InformationData {
  final User? personalInformation;
  final BusinessInformation? businessInformation;
  final OnboardingSteps? steps;

  InformationData({
    this.personalInformation,
    this.businessInformation,
    this.steps,
  });

  factory InformationData.fromJson(Map<String, dynamic> json) => InformationData(
    personalInformation: json["personal_information"] == null ? null : User.fromJson(json["personal_information"]),
    businessInformation: json["business_information"] == null ? null : BusinessInformation.fromJson(json["business_information"]),
    steps: json["steps"] == null ? null : OnboardingSteps.fromJson(json["steps"]),
  );

  Map<String, dynamic> toJson() => {
    "personal_information": personalInformation?.toJson(),
    "business_information": businessInformation?.toJson(),
    "steps": steps?.toJson(),
  };
}