import '../../api/resource/resource.dart';
import '../entities/user_entity/user_entity.dart';

abstract class UserRepository {
  Stream<Result<UserEntity>> fetchUserDetails(
      {required bool fetchesFromLocalDB, required bool fetchesFromRemote});
  Stream<Result<UserEntity>> fetchProfileInformation(
      {required bool fetchesFromLocalDB, bool fetchesFromLocalOnly = false});
  Future<Result<bool>> logout();
  Future<UserEntity?> getCurrentUserFromCache();
  Future<String?> getCurrentUserId();
}
