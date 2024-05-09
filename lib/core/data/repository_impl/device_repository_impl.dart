import 'dart:async';
import 'package:flutter_udid/flutter_udid.dart';

import '../../api/exceptions/custom_exception.dart';
import '../../api/resource/resource.dart';
import '../../domain/entities/app_information_entity/app_information_entity.dart';
import '../../domain/repositories/device_repository.dart';
import '../data_sources/device_data_sources/device_local_data_source.dart';
import '../data_sources/device_data_sources/device_remote_data_source.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl({
    required DeviceRemoteDataSource remoteDataSource,
    required DeviceLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;
  final DeviceRemoteDataSource _remoteDataSource;
  final DeviceLocalDataSource _localDataSource;

  @override
  Future<Result<bool>> registerDevice(
      {required String userId,
      required String name,
      required String platform,
      required String versionName,
      required int buildNumber,
      String? pushToken}) async {
    try {
      final deviceId = await FlutterUdid.consistentUdid;
      final deviceData = await _remoteDataSource.registerDevice(
          userId: userId,
          deviceId: deviceId,
          name: name,
          platform: platform,
          versionName: versionName,
          buildNumber: buildNumber.toString(),
          pushToken: pushToken);
      await _localDataSource.saveCurrentDeviceId(deviceData.id);
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> setFCMToken(
      {required String userId, required String fcmToken}) async {
    final deviceId = await _localDataSource.getCurrentDeviceId();
    if (deviceId == null) {
      return const Result.success(false);
    }
    try {
      final _ = await _remoteDataSource.setFCMToken(
          userId: userId, deviceId: deviceId, token: fcmToken);
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> updateDevice(
      {required String userId,
      required String name,
      required String versionName,
      required int buildNumber}) async {
    final deviceId = await _localDataSource.getCurrentDeviceId();
    if (deviceId == null) {
      return const Result.success(false);
    }
    try {
      final _ = await _remoteDataSource.updateDevice(
          userId: userId,
          deviceId: deviceId,
          name: name,
          versionName: versionName,
          buildNumber: buildNumber.toString());
      await _localDataSource.saveCurrentDeviceId(deviceId);
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> deleteDevice({required String userId}) async {
    final deviceId = await _localDataSource.getCurrentDeviceId();
    if (deviceId == null) {
      return const Result.success(false);
    }
    try {
      final _ = await _remoteDataSource.deleteDevice(
          userId: userId, deviceId: deviceId);
      await _localDataSource.removeDeviceId();
      return const Result.success(true);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<AppInformationEntity>> getAppInformation() async {
    try {
      final appInformation = await _remoteDataSource.getAppInformation();

      return Result.success(appInformation.asEntity());
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }
}
