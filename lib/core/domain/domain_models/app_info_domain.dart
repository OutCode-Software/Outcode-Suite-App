import '../../../services/device_information_retrieval_service/device_information.dart';

class AppInfoDomain {
  AppInfoDomain(this._deviceInformation, this.hasAppUpdate, this.showsAppIcon);
  final DeviceInformation _deviceInformation;
  final bool hasAppUpdate;
  final bool showsAppIcon;

  String get versionName => _deviceInformation.versionName;
  String get buildNumber => _deviceInformation.buildNumber.toString();
  String? get link => _deviceInformation.link;
}
