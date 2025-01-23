import 'dart:convert';

import 'package:http/http.dart' as http;

// temp
void verifyEmail(String otp) async {
  final response = await http.post(
    Uri.parse(''), // api endpoint for verify email
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'otp': otp,
    }),
  );
}