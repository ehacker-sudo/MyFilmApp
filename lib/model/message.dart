class Message {
  final bool result;
  final String message;
  final String userId;
  final String accessToken;
  final String tokenType;
  final String expiresAt;

  Message({
    bool? result,
    String? message,
    String? userId,
    String? accessToken,
    String? tokenType,
    String? expiresAt,
  })  : result = result ?? false,
        message = message ?? "",
        userId = userId ?? "",
        accessToken = accessToken ?? "",
        tokenType = tokenType ?? "",
        expiresAt = expiresAt ?? "";

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      result: json["result"] ?? false,
      message: json["message"] ?? "",
      userId: json["user_id"] ?? "",
      accessToken: json["access_token"] ?? "",
      tokenType: json["token_type"] ?? "",
      expiresAt: json["expires_at"] ?? "",
    );
  }
}
