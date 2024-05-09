import 'dart:async';

import '../../../features/authentication/account/login/models/login_form_validation_model.dart';
import '../../../injector/rest_client_module.dart';
import '../../api/exceptions/custom_exception.dart';
import '../../api/resource/resource.dart';
import '../../domain/entities/oauth_token_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_sources/auth_local_datasource.dart';
import '../data_sources/auth_data_sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required AuthRemoteDataSource remoteDataSource,
      required AuthLocalDataSource localDataSource})
      : _authRemoteDataSource = remoteDataSource,
        _authLocalDataSource = localDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<Result<OauthTokenEntity>> loginUser(
      LoginRequestModel loginRequestModel) async {
    try {
      final response = await _authRemoteDataSource.loginUser(loginRequestModel);
      final tokenEntity = response.asEntity();
      await _authLocalDataSource.cacheToken(tokenEntity);
      RestClientModule.injectRefreshTokenInterceptor();
      return Result.success(tokenEntity);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<OauthTokenEntity>> fetchCachedToken() async {
    try {
      final tokenEntity = await _authLocalDataSource.getLastToken();
      RestClientModule.injectRefreshTokenInterceptor();
      return Result.success(tokenEntity);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<void> logout() {
    return _authLocalDataSource.logout();
  }

  @override
  Future<Result<bool>> setUpNewPassword(
      String emailAddress, String password, String securityCode) async {
    try {
      final _ = await _authRemoteDataSource.setNewPassword(
          emailAddress, password, securityCode);
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<OauthTokenEntity>> signUpUser(String firstName, String lastName,
      String emailAddress, String password) async {
    try {
      final response = await _authRemoteDataSource.signUpUser(
          firstName, lastName, emailAddress, password);
      return Result.success(response.asEntity());
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> requestForgotPassword(String emailAddress) async {
    try {
      final _ = await _authRemoteDataSource.requestForgotPassword(emailAddress);
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }
}
