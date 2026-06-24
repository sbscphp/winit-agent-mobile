import 'information_data.dart';

class LoginData {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final InformationData? user;
  final RefreshToken? refreshToken;

  LoginData({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
    this.refreshToken
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    user: json["user"] == null ? null : InformationData.fromJson(json["user"]),
    refreshToken: json["refresh_token"] == null ? null : RefreshToken.fromJson(json["refresh_token"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user": user?.toJson(),
    "refresh_token": refreshToken?.toJson(),
  };
}

class RefreshToken {
  final String? token;
  final String? tokenType;


  RefreshToken({
    this.token,
    this.tokenType,
  });

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
    token: json["token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "token_type": tokenType,
  };
}