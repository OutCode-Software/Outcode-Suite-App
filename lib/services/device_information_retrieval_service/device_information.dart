class DeviceInformation {
  DeviceInformation(
      {required this.name,
      required this.platform,
      required this.versionName,
      required this.buildNumber,
      this.link});
  final String name;
  final String platform;
  final String versionName;
  final int buildNumber;
  final String? link;
}
