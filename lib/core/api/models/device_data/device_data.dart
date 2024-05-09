import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../base/utils/utilities.dart';

part 'device_data.g.dart';

@JsonSerializable()
class DeviceData {
  DeviceData(
      {required this.id,
      required this.buildNumber,
      required this.name,
      required this.platform,
      required this.versionName,
      this.pushToken});

  factory DeviceData.fromJson(Map<String, dynamic> json) =>
      _$DeviceDataFromJson(json);

  factory DeviceData.fromDocument(DocumentSnapshot doc) {
    String? pushToken;
    try {
      pushToken = doc.get(DeviceData.pushTokenKey);
    } catch (e) {
      Utilities.printObj(e);
    }

    final device = DeviceData(
        id: doc.get(DeviceData.idKey),
        buildNumber: doc.get(DeviceData.buildNumberKey),
        platform: doc.get(DeviceData.platformKey),
        name: doc.get(DeviceData.nameKey),
        versionName: doc.get(DeviceData.versionNameKey),
        pushToken: pushToken);
    return device;
  }
  static const idKey = 'id';
  static const buildNumberKey = 'buildNumber';
  static const nameKey = 'name';
  static const platformKey = 'platform';
  static const pushTokenKey = 'pushToken';
  static const versionNameKey = 'versionName';

  final String id;
  final String buildNumber;
  final String platform;
  final String name;
  final String? pushToken;
  final String versionName;
  Map<String, dynamic> toJson() => _$DeviceDataToJson(this);
}
