import 'dart:convert';
import 'package:dotenv/dotenv.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// temp
void signup(Map<String, String> userDetails) async {
  DotEnv env = DotEnv(includePlatformEnvironment: true)
    ..load();
  
  final response = await http.post(
    Uri.parse('${env['CONNECTION_SCHEME']}${env['CONNECTION_IP']}:${env['CONNECTION_PORT']}/register'), // api endpoint for signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': userDetails['firstName'] ?? '',
      'lastName': userDetails['lastName'] ?? '',
      'email': userDetails['email'] ?? '',
      'username': userDetails['username'] ?? '',
      'password': userDetails['password'] ?? '',
    }),
  );

  debugPrint(response.body);
}