import 'dart:async';

abstract class LocalStorageService {
  String accessTokenKey = '';
  String refreshTokenKey = '';
  String refreshTokenDurationKey = '';
  String accessTokenDurationKey = '';
  String userKey = '';
  String userIdKey = '';
  String deviceIdKey = '';

  FutureOr<void> init();

  Future<String?> get accessToken;
  Future<String?> get refreshToken;
  Future<String?> get refreshTokenDuration;
  Future<String?> get accessTokenDuration;
  Future<String?> get user;
  Future<String?> get userId;
  Future<String?> get deviceId;

  Future<void> setAccessToken(String? accessToken);
  Future<void> setRefreshToken(String? refreshToken);
  Future<void> setAccessTokenDuration(String? accessTokenDuration);
  Future<void> setRefreshTokenDuration(String? refreshTokenDuration);
  Future<void> setDeviceId(String? deviceId);
  Future<void> setUser(String? user);
  Future<void> setUserId(String? userId);
  Future<void> clearLocalCache();

  void setValue({required String key, required dynamic value});
  dynamic getValue({required String key});
}
