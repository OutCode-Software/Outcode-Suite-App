// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceData _$DeviceDataFromJson(Map<String, dynamic> json) => DeviceData(
      id: json['id'] as String,
      buildNumber: json['buildNumber'] as String,
      name: json['name'] as String,
      platform: json['platform'] as String,
      versionName: json['versionName'] as String,
      pushToken: json['pushToken'] as String?,
    );

Map<String, dynamic> _$DeviceDataToJson(DeviceData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildNumber': instance.buildNumber,
      'platform': instance.platform,
      'name': instance.name,
      'pushToken': instance.pushToken,
      'versionName': instance.versionName,
    };
