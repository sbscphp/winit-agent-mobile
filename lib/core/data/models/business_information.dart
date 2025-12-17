class BusinessInformation {
  final dynamic tinNumber;
  final dynamic rcNumber;
  final dynamic businessPhone;
  final dynamic businessPhoneNumber2;
  final dynamic businessEmail;
  final dynamic businessEmail2;
  final dynamic businessStateOfResidence;
  final dynamic businessLgaOfResidence;
  final dynamic businessAddress;
  final dynamic businessLandmark;
  final List<String>? posAgents;
  final List<String>? lotteryAgents;
  final List<String>? otherAgents;

  BusinessInformation({
    this.tinNumber,
    this.rcNumber,
    this.businessPhone,
    this.businessPhoneNumber2,
    this.businessEmail,
    this.businessEmail2,
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
    rcNumber: json["rc_number"],
    businessPhone: json["business_phone"],
    businessPhoneNumber2: json["business_phone_number_2"],
    businessEmail: json["business_email"],
    businessEmail2: json["business_email_2"],
    businessStateOfResidence: json["business_state_of_residence"],
    businessLgaOfResidence: json["business_lga_of_residence"],
    businessAddress: json["business_address"],
    businessLandmark: json["business_landmark"],
    posAgents: json["pos_agents"] == null ? [] : List<String>.from(json["pos_agents"]!.map((x) => x)),
    lotteryAgents:json["lottery_agents"] == null ? [] : List<String>.from(json["lottery_agents"]!.map((x) => x)),
    otherAgents: json["other_agents"] == null ? [] : List<String>.from(json["other_agents"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tin_number": tinNumber,
    "rc_number": rcNumber,
    "business_phone": businessPhone,
    "business_phone_number_2": businessPhoneNumber2,
    "business_email": businessEmail,
    "business_email_2": businessEmail2,
    "business_state_of_residence": businessStateOfResidence,
    "business_lga_of_residence": businessLgaOfResidence,
    "business_address": businessAddress,
    "business_landmark": businessLandmark,
    "pos_agents": posAgents == null ? [] : List<dynamic>.from(posAgents!.map((x) => x)),
    "lottery_agents": lotteryAgents == null ? [] : List<dynamic>.from(lotteryAgents!.map((x) => x)),
    "other_agents": otherAgents == null ? [] : List<dynamic>.from(otherAgents!.map((x) => x)),
  };
}