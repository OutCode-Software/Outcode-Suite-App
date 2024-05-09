import '../../api/resource/resource.dart';
import '../entities/app_information_entity/app_information_entity.dart';

abstract class DeviceRepository {
  Future<Result<bool>> registerDevice(
      {required String userId,
      required String name,
      required String platform,
      required String versionName,
      required int buildNumber,
      String? pushToken});

  Future<Result<bool>> updateDevice(
      {required String userId,
      required String name,
      required String versionName,
      required int buildNumber});

  Future<Result<AppInformationEntity>> getAppInformation();

  Future<Result<bool>> deleteDevice({required String userId});

  Future<Result<bool>> setFCMToken(
      {required String userId, required String fcmToken});
}
