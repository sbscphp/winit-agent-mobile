class FrontendLinksConfiguration {
  final String? faq;
  final String? claimPrize;
  final String? gameRules;
  final String? privacyPolicy;
  final String? contactUs;

  FrontendLinksConfiguration({
    this.faq,
    this.claimPrize,
    this.gameRules,
    this.privacyPolicy,
    this.contactUs,
  });

  factory FrontendLinksConfiguration.fromJson(Map<String, dynamic> json) => FrontendLinksConfiguration(
    faq: json["faq"],
    claimPrize: json["claim_prize"],
    gameRules: json["game_rules"],
    privacyPolicy: json["privacy_policy"],
    contactUs: json["contact_us"],
  );

  Map<String, dynamic> toJson() => {
    "faq": faq,
    "claim_prize": claimPrize,
    "game_rules": gameRules,
    "privacy_policy": privacyPolicy,
    "contact_us": contactUs,
  };
}