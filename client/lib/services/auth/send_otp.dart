import 'dart:convert';

import 'package:http/http.dart' as http;

// temp
void sendOtp(String emailAddress) async {
  final response = await http.post(
    Uri.parse(''), // api endpoint for send otp
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'emailAddress': emailAddress,
    }),
  );
}