class User {
  final String? uuid;
  final String? email;
  final String? temporaryId;
  final String? phoneNumber;
  final dynamic avatar;
  final dynamic firstname;
  final dynamic lastname;
  final dynamic dateOfBirth;
  final dynamic gender;
  final dynamic address;
  final dynamic landmark;
  final dynamic lgaOfResidence;
  final bool? hasTransactionPin;
  final String? referralCode;
  final String? referralLink;
  final dynamic referralBalance;
  final dynamic registrationStep;
  final dynamic registrationStepStatus;

  User({
    this.uuid,
    this.email,
    this.temporaryId,
    this.phoneNumber,
    this.avatar,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.landmark,
    this.lgaOfResidence,
    this.hasTransactionPin,
    this.referralCode,
    this.referralLink,
    this.referralBalance,
    this.registrationStep,
    this.registrationStepStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uuid: json["uuid"],
    email: json["email"],
    temporaryId: json["temporary_id"],
    phoneNumber: json["phone_number"],
    avatar: json["avatar"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    address: json["address"],
    landmark: json["landmark"],
    lgaOfResidence: json["lga_of_residence"],
    hasTransactionPin: json["has_transaction_pin"],
    referralCode: json["referral_code"],
    referralLink: json["referral_link"],
    referralBalance: json["referral_balance"],
    registrationStep: json["registration_step"],
    registrationStepStatus: json["registration_step_status"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "email": email,
    "temporary_id": temporaryId,
    "phone_number": phoneNumber,
    "avatar": avatar,
    "firstname": firstname,
    "lastname": lastname,
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "address": address,
    "landmark": landmark,
    "lga_of_residence": lgaOfResidence,
    "has_transaction_pin": hasTransactionPin,
    "referral_code": referralCode,
    "referral_link": referralLink,
    "referral_balance": referralBalance,
    "registration_step": registrationStep,
    "registration_step_status": registrationStepStatus,
  };
}