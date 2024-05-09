class SignUpEntity {
  SignUpEntity(
      {required this.id,
      required this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.birthDate,
      this.location,
      this.avatar});
  String id;
  String email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? birthDate;
  String? location;
  String? avatar;
}
