class QoreData {
  final String? sessionId;
  final String? sdkSessionToken;



  QoreData({
    this.sessionId,
    this.sdkSessionToken,
  });

  factory QoreData.fromJson(Map<String, dynamic> json) => QoreData(
      sessionId: json["sessionId"],
      sdkSessionToken: json["sdkSessionToken"],
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "sdkSessionToken": sdkSessionToken,
  };
}