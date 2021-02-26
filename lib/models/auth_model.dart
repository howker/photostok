class Auth {
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final String scope;
  final int createdAt;

  Auth(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.scope,
      this.createdAt});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      refreshToken: json['refresh_token'],
      scope: json['scope'],
      createdAt: json['created_at'],
    );
  }
}
