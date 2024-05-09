class OauthTokenEntity {
  OauthTokenEntity(
      {required this.token, required this.refreshToken, required this.userId});
  String token;
  String refreshToken;
  String userId;
}
