import 'package:app/base/utils/strings.dart';

class LoginRequestModel {
  LoginRequestModel({required String email, required String password})
      : _email = email.trim(),
        _password = password;
  final String _email;
  final String _password;

  bool emailInputValidationError = false;
  bool passwordInputValidationError = false;
  final List<String> _validationErrors = [];

  bool get hasError {
    return emailInputValidationError || passwordInputValidationError;
  }

  String get email => _email;
  String get password => _password.trim();

  String get formattedErrorMessage {
    return _validationErrors.map((e) => e.localized).join('\n');
  }

  LoginRequestModel? validate() {
    if (_email.isInvalidEmail) {
      emailInputValidationError = true;
      _validationErrors.add('LoginScreen_validation_emailValidation_message');
    }
    if (_password.isEmpty) {
      passwordInputValidationError = true;
      _validationErrors
          .add('LoginScreen_validation_passwordValidation_message');
    }
    return hasError ? this : null;
  }
}
