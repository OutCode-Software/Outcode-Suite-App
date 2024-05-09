import '../../../api/clients/rest_client/authorized_api_client/authorized_api_client.dart';
import '../../../api/exceptions/exception_handler.dart';
import '../../../api/models/user_data/user_data.dart';
import '../../../api/models/user_data_wrapper/user_data_wrapper.dart';

abstract class UserRemoteDataSource {
  Future<UserDataWrapper> getUserDetail();
  Future<UserData> getProfileInformation(String id);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  UserRemoteDataSourceImpl({required AuthorizedApiClient userApiClient})
      : _userApiClient = userApiClient;

  final AuthorizedApiClient _userApiClient;

  @override
  Future<UserDataWrapper> getUserDetail() async {
    try {
      return await _userApiClient.fetchUserDetail();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<UserData> getProfileInformation(String id) async {
    try {
      final response = await _userApiClient.fetchProfileInformation(id);
      return response.user;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
