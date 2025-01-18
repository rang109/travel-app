import 'dart:convert';

import 'package:http/http.dart' as http;

// temp
void signup(Map<String, String> userDetails) async {
  final response = await http.post(
    Uri.parse(''),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': userDetails['firstName'] ?? '',
      'lastName': userDetails['lastName'] ?? '',
      'emailAddress': userDetails['emailAddress'] ?? '',
      'username': userDetails['username'] ?? '',
      'password': userDetails['password'] ?? '',
    }),
  );
}