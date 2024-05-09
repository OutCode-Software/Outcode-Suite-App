import '../../../../services/local_storage_service/local_storage_service.dart';
import '../../../api/exceptions/custom_exception.dart';
import '../../../domain/entities/oauth_token_entity.dart';

abstract class AuthLocalDataSource {
  Future<OauthTokenEntity> getLastToken();
  Future<void> cacheToken(OauthTokenEntity loginEntity);
  Future<void> logout();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;
  final LocalStorageService _localStorageService;

  @override
  Future<void> cacheToken(OauthTokenEntity loginEntity) {
    _localStorageService
      ..setAccessToken(loginEntity.token)
      ..setUserId(loginEntity.userId);
    return _localStorageService.setRefreshToken(loginEntity.refreshToken);
  }

  @override
  Future<OauthTokenEntity> getLastToken() async {
    final accessToken = await _localStorageService.accessToken;
    final refreshToken = await _localStorageService.refreshToken;
    final userId = await _localStorageService.userId;
    if (accessToken == null || refreshToken == null || userId == null) {
      throw CustomException.sessionExpired();
    }
    return Future.value(OauthTokenEntity(
        token: accessToken, refreshToken: refreshToken, userId: userId));
  }

  @override
  Future<void> logout() {
    _localStorageService
      ..setAccessToken(null)
      ..setRefreshToken(null)
      ..setUserId(null)
      ..setAccessTokenDuration(null)
      ..setRefreshTokenDuration(null)
      ..setUser(null);
    return _localStorageService.setRefreshToken(null);
  }
}
