import 'dart:convert';
import 'package:dotenv/dotenv.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// temp
Future<String?> signup(Map<String, String> userDetails) async {
  DotEnv env = DotEnv(includePlatformEnvironment: true)
    ..load();
  
  final response = await http.post(
    Uri.parse('${env['CONNECTION_SCHEME']}${env['CONNECTION_IP']}:${env['CONNECTION_PORT']}/register/'), // api endpoint for signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name': userDetails['firstName'] ?? '',
      'last_name': userDetails['lastName'] ?? '',
      'email': userDetails['email'] ?? '',
      'username': userDetails['username'] ?? '',
      'password1': userDetails['password'] ?? '',
      'password2': userDetails['confirmPassword'] ?? '',
    }),
  );

  debugPrint(response.body);

  if (response.statusCode >= 400) {
    return jsonDecode(response.body)['message'];
  }

  return null;
}