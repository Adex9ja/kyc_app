class Secret {
  final String merchantKey;
  final String merchantID;
  Secret({this.merchantKey = "", this.merchantID = ""});
  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(merchantKey: jsonMap["key"], merchantID: jsonMap['mid']);
  }
}