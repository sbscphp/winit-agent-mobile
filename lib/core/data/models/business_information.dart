class BusinessInformation {
  final dynamic tinNumber;
  final dynamic businessPhone;
  final dynamic businessPhoneNumber2;
  final dynamic businessEmail;
  final dynamic businessStateOfResidence;
  final dynamic businessLgaOfResidence;
  final dynamic businessAddress;
  final dynamic businessLandmark;
  final dynamic posAgents;
  final dynamic lotteryAgents;
  final dynamic otherAgents;

  BusinessInformation({
    this.tinNumber,
    this.businessPhone,
    this.businessPhoneNumber2,
    this.businessEmail,
    this.businessStateOfResidence,
    this.businessLgaOfResidence,
    this.businessAddress,
    this.businessLandmark,
    this.posAgents,
    this.lotteryAgents,
    this.otherAgents,
  });

  factory BusinessInformation.fromJson(Map<String, dynamic> json) => BusinessInformation(
    tinNumber: json["tin_number"],
    businessPhone: json["business_phone"],
    businessPhoneNumber2: json["business_phone_number_2"],
    businessEmail: json["business_email"],
    businessStateOfResidence: json["business_state_of_residence"],
    businessLgaOfResidence: json["business_lga_of_residence"],
    businessAddress: json["business_address"],
    businessLandmark: json["business_landmark"],
    posAgents: json["pos_agents"],
    lotteryAgents: json["lottery_agents"],
    otherAgents: json["other_agents"],
  );

  Map<String, dynamic> toJson() => {
    "tin_number": tinNumber,
    "business_phone": businessPhone,
    "business_phone_number_2": businessPhoneNumber2,
    "business_email": businessEmail,
    "business_state_of_residence": businessStateOfResidence,
    "business_lga_of_residence": businessLgaOfResidence,
    "business_address": businessAddress,
    "business_landmark": businessLandmark,
    "pos_agents": posAgents,
    "lottery_agents": lotteryAgents,
    "other_agents": otherAgents,
  };
}