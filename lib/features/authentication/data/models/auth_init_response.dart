class AuthInitResponse {

  final String accessToken;
  final String tokenType;
  final int expiresIn;

  AuthInitResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthInitResponse.fromJson(Map<String, dynamic> json) {
    return AuthInitResponse(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
    );
  }
}