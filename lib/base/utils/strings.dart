import 'package:easy_localization/easy_localization.dart';

extension ExtString on String {
  bool get isInvalidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return !emailRegExp.hasMatch(this);
  }

  bool get isInvalidOTPCode {
    return length != 6;
  }

  bool get isInValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return !nameRegExp.hasMatch(this);
  }

  bool get isInValidAlphabeticalText {
    final regExp = RegExp('[a-zA-Z]');
    return !regExp.hasMatch(this);
  }

  bool get isInValidPassword {
    final rexExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return !rexExp.hasMatch(this);
  }

  bool get isInValidPhone {
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,}$');
    return !phoneRegExp.hasMatch(this);
  }

  bool equalsTo(String secondString) {
    return this == secondString;
  }

  bool isNotEqualTo(String secondString) {
    return this != secondString;
  }

  String get localized => this.tr();

  String? get firstCharacter => isEmpty ? null : this[0];

  String get initials {
    final items = split(' ')
        .map((e) => e.firstCharacter)
        .where((element) => element != null)
        .where((element) => element!.isNotEmpty)
        .toList();
    final length = items.length;
    if (items.isEmpty) {
      return '';
    } else if (length == 1) {
      return items.join();
    } else {
      return [items[0], items[length - 1]].join();
    }
  }
}
