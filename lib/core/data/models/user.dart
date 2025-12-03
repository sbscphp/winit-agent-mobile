class User {
  final String? uuid;
  final String? email;
  final String? uniqueID;
  final String? temporaryId;
  final String? phoneNumber;
  final dynamic avatar;
  final dynamic firstname;
  final dynamic lastname;
  final dynamic dateOfBirth;
  final dynamic birthdate;
  final dynamic gender;
  final dynamic address;
  final dynamic landmark;
  final dynamic lgaOfResidence;
  bool? hasTransactionPin;
  final String? referralCode;
  final String? referralLink;
  final dynamic referralBalance;
  final dynamic registrationStep;
  final dynamic registrationStepStatus;
  final String? otherPhoneNumber;
  final String? otherEmail;
  final dynamic spendLimitStatus;
  final dynamic exclusionType;
  final dynamic excludeTill;
  final dynamic parentName;
  final List<String>? roles;
  final List<String>? permissions;

  User({
    this.uuid,
    this.email,
    this.uniqueID,
    this.temporaryId,
    this.phoneNumber,
    this.avatar,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.birthdate,
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
    this.otherPhoneNumber,
    this.otherEmail,
    this.spendLimitStatus,
    this.exclusionType,
    this.excludeTill,
    this.parentName,
    this.roles,
    this.permissions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uuid: json["uuid"],
    email: json["email"],
    uniqueID: json["uniqueID"],
    temporaryId: json["temporary_id"],
    phoneNumber: json["phone_number"],
    avatar: json["avatar"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    dateOfBirth: json["date_of_birth"],
    birthdate: json["birthdate"],
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
    otherPhoneNumber: json["other_phone_number"],
    otherEmail: json["other_email"],
    spendLimitStatus: json["spend_limit_status"],
    exclusionType: json["exclusion_type"],
    excludeTill: json["exclude_till"],
    parentName: json["parent_name"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    permissions: json["permissions"] == null ? [] : List<String>.from(json["permissions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "email": email,
    "uniqueID": uniqueID,
    "temporary_id": temporaryId,
    "phone_number": phoneNumber,
    "avatar": avatar,
    "firstname": firstname,
    "lastname": lastname,
    "date_of_birth": dateOfBirth,
    "birthdate": birthdate,
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
    "other_phone_number": otherPhoneNumber,
    "other_email": otherEmail,
    "spend_limit_status": spendLimitStatus,
    "exclusion_type": exclusionType,
    "exclude_till": excludeTill,
    "parent_name": parentName,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
  };
}