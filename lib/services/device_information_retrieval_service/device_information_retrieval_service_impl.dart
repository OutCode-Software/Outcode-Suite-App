import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../base/constants/constants.dart';
import 'device_information.dart';
import 'device_information_retrieval_service.dart';

class DeviceInformationRetrievalServiceImpl
    implements DeviceInformationRetrievalService {
  DeviceInformationRetrievalServiceImpl(
      {required DeviceInfoPlugin deviceInfoPlugin,
      required PackageInfo packageInfo})
      : _deviceInfoPlugin = deviceInfoPlugin,
        _packageInfo = packageInfo;

  final DeviceInfoPlugin _deviceInfoPlugin;
  final PackageInfo _packageInfo;

  @override
  Future<DeviceInformation> fetchDeviceInformation() async {
    if (Platform.isAndroid) {
      final androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      return DeviceInformation(
          name: androidDeviceInfo.model ?? 'Android Model',
          platform: 'android',
          versionName: Constants.androidVersion,
          buildNumber: int.tryParse(_packageInfo.buildNumber) ?? 0);
    } else {
      final iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      return DeviceInformation(
          name: iosDeviceInfo.model ?? '',
          platform: 'ios',
          versionName: Constants.iosVersion,
          buildNumber: int.tryParse(_packageInfo.buildNumber) ?? 0);
    }
  }
}
