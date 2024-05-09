import 'dart:async';

import '../../../base/utils/utilities.dart';
import '../../api/exceptions/custom_exception.dart';
import '../../api/resource/resource.dart';
import '../../domain/entities/page_meta_entity/page_meta_entity.dart';
import '../../domain/entities/paged_entity/paged_entity.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_data_sources/user_local_datasource.dart';
import '../data_sources/user_data_sources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
      {required UserRemoteDataSource remoteDataSource,
      required UserLocalDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  @override
  Stream<Result<UserEntity>> fetchUserDetails(
      {required bool fetchesFromLocalDB,
      required bool fetchesFromRemote}) async* {
    if (fetchesFromLocalDB) {
      try {
        final cachedUserInfo = await _localDataSource.getUserDetails();
        if (cachedUserInfo != null) {
          yield Result.success(cachedUserInfo);
          if (!fetchesFromRemote) {
            return;
          }
        }
      } on CustomException catch (e) {
        yield Result.error(e);
        return;
      }
    }
    try {
      final userResponse = await _remoteDataSource.getUserDetail();
      final userEntity = userResponse.user.asEntity();
      await _localDataSource.saveUser(userEntity);
      yield Result.success(userEntity);
    } on CustomException catch (e) {
      yield Result.error(e);
    }
  }

  @override
  Stream<Result<UserEntity>> fetchProfileInformation(
      {required bool fetchesFromLocalDB,
      bool fetchesFromLocalOnly = false}) async* {
    final currentUserId = await _localDataSource.getCurrentUserId();
    if (currentUserId == null) {
      throw CustomException.sessionExpired();
    }
    if (fetchesFromLocalDB) {
      try {
        final cachedUserInfo = await _localDataSource.getUserDetails();
        if (cachedUserInfo != null) {
          yield Result.success(cachedUserInfo);
          if (fetchesFromLocalOnly) {
            return;
          }
        }
      } catch (e) {
        Utilities.printObj(e);
      }
    }
    try {
      final userResponse =
          await _remoteDataSource.getProfileInformation(currentUserId);
      final userEntity = userResponse.asEntity();
      await _localDataSource.saveUser(userEntity);
      yield Result.success(userEntity);
    } on CustomException catch (e) {
      yield Result.error(e);
    }
  }

  @override
  Future<Result<bool>> logout() async {
    await _localDataSource.logoutUser();
    return const Result.success(true);
  }

  @override
  Future<UserEntity?> getCurrentUserFromCache() async {
    try {
      final cachedUserInfo = await _localDataSource.getUserDetails();
      if (cachedUserInfo != null) {
        return cachedUserInfo;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<PagedEntity<UserEntity>?> _fetchUsersFromLocalDataSource(
      int page, int size,
      {bool fetchsFromLocal = true}) async {
    if (fetchsFromLocal && page == 0) {
      try {
        final cachedProjects = await _localDataSource.getUsers(page, size);
        return PagedEntity(PageMetaEntity(0, 1, 1, 1, 1, 1), cachedProjects);
      } catch (e) {
        Utilities.printObj(e);
      }
    }
    return null;
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _localDataSource.getCurrentUserId();
  }
}
