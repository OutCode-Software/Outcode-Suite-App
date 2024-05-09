import '../../../api/clients/rest_client/authorized_api_client/authorized_api_client.dart';
import '../../../api/exceptions/custom_exception.dart';
import '../../../api/exceptions/exception_handler.dart';
import '../../../api/models/app_information_data/app_information_data.dart';
import '../../../api/models/device_data/device_data.dart';
import '../../../api/models/empty_success_response/empty_success_response.dart';

abstract class DeviceRemoteDataSource {
  Future<DeviceData> registerDevice(
      {required String userId,
      required String deviceId,
      required String name,
      required String platform,
      required String versionName,
      required String buildNumber,
      String? pushToken});
  Future<EmptySuccessResponse> updateDevice(
      {required String userId,
      required String deviceId,
      required String name,
      required String versionName,
      required String buildNumber});
  Future<EmptySuccessResponse> deleteDevice(
      {required String userId, required String deviceId});
  Future<EmptySuccessResponse> setFCMToken(
      {required String userId,
      required String deviceId,
      required String token});
  Future<AppInformationData> getAppInformation();
}

class DeviceRemoteDataSourceImpl extends DeviceRemoteDataSource {
  DeviceRemoteDataSourceImpl({required AuthorizedApiClient userApiClient})
      : _userApiClient = userApiClient;

  final AuthorizedApiClient _userApiClient;

  @override
  Future<DeviceData> registerDevice(
      {required String userId,
      required String deviceId,
      required String name,
      required String platform,
      required String versionName,
      required String buildNumber,
      String? pushToken}) async {
    try {
      return DeviceData.fromJson({});
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<EmptySuccessResponse> setFCMToken(
      {required String userId,
      required String deviceId,
      required String token}) async {
    try {
      //[todo]
      return EmptySuccessResponse.fromJson({});
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<EmptySuccessResponse> updateDevice(
      {required String userId,
      required String deviceId,
      required String name,
      required String versionName,
      required String buildNumber}) async {
    try {
      return EmptySuccessResponse.fromJson({});
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<EmptySuccessResponse> deleteDevice(
      {required String userId, required String deviceId}) async {
    try {
      return EmptySuccessResponse.fromJson({});
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<AppInformationData> getAppInformation() async {
    try {
      return AppInformationData.fromJson({});
    } catch (e) {
      throw ExceptionHandler.handleException(
          CustomException.error('App information not available'));
    }
  }
}
