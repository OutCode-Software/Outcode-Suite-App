import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain_models/user_domain.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  UserEntity(this.id, this.email);

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  final String id;
  final String email;
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
  UserDomain toDomain() => UserDomain(this, false);
}
