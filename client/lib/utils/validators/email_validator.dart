import 'package:is_valid/is_valid.dart';

String? emailAddressValidator(String? emailAddress) {
    return (IsValid.validateEmail(emailAddress ?? '')) ?
      null :
      'Please enter a valid email address';
  }