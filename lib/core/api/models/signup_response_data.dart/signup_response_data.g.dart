// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseData _$SignUpResponseDataFromJson(Map<String, dynamic> json) =>
    SignUpResponseData(
      json['id'] as String,
      json['email'] as String,
    )
      ..firstName = json['firstName'] as String?
      ..lastName = json['lastName'] as String?
      ..phoneNumber = json['phoneNumber'] as String?
      ..birthDate = json['birthDate'] as String?
      ..location = json['location'] as String?
      ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$SignUpResponseDataToJson(SignUpResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate,
      'location': instance.location,
      'avatar': instance.avatar,
    };
