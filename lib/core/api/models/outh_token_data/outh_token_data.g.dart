// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outh_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthTokenData _$OauthTokenDataFromJson(Map<String, dynamic> json) =>
    OauthTokenData(
      json['access_token'] as String,
      json['refresh_token'] as String,
      json['user_id'] as String,
    );

Map<String, dynamic> _$OauthTokenDataToJson(OauthTokenData instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user_id': instance.userId,
    };
