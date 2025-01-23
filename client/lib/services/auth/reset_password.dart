import 'dart:convert';
import 'package:dotenv/dotenv.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// temp
void resetPassword(String password) async {
  DotEnv env = DotEnv(includePlatformEnvironment: true)
    ..load();
  
  final response = await http.post(
    Uri.parse('${env['CONNECTION_SCHEME']}${env['CONNECTION_IP']}:${env['CONNECTION_PORT']}/reset-password'), // api endpoint for signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'password': password,
    }),
  );

  debugPrint(response.body);
}