import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/signup_enitty.dart';

part 'signup_response_data.g.dart';

@JsonSerializable()
class SignUpResponseData {
  SignUpResponseData(this.id, this.email);

  factory SignUpResponseData.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseDataFromJson(json);
  final String id;
  final String email;
  late final String? firstName;
  late final String? lastName;
  late final String? phoneNumber;
  late final String? birthDate;
  late final String? location;
  late final String? avatar;

  SignUpEntity asEntity() => SignUpEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      location: location,
      avatar: avatar);
}
