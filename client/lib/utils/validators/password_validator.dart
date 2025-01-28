import 'package:is_valid/is_valid.dart';

String? passwordValidator(String? password) {
    Map<PasswordValidation, dynamic> passwordValidationOptions = {
      PasswordValidation.minLength: 8,
      PasswordValidation.disallowLetters: false,
      PasswordValidation.disallowNumbers: false,
      PasswordValidation.disallowSpecialChars: false,
    };
    
    if (password == null) {
      return 'Password is empty.';
    } else if (password.length < 8) {
      return 'Your password is too short.';
    } else if (!RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]').hasMatch(password)) {
      return 'Your password should contain at least one number and one special character.';
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]').hasMatch(password)) {
      return 'Your password should contain at least one special character.';
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Your password should contain at least one number.';
    } else if (IsValid.validatePassword(password, passwordValidationOptions)) {
      return null;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }