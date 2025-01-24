import 'dart:convert';
import 'package:dotenv/dotenv.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// temp
Future<String?> verifyEmail(String otp, String emailAddress) async {
  DotEnv env = DotEnv(includePlatformEnvironment: true)
    ..load();
  
  final response = await http.post(
    Uri.parse(
      '${env['CONNECTION_SCHEME']}${env['CONNECTION_IP']}:${env['CONNECTION_PORT']}/verify-email/$emailAddress/'
      ), // api endpoint for verify email
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'otp_code': otp,
    }),
  );

  debugPrint(response.body);

  if (response.statusCode >= 400) {
    return jsonDecode(response.body)['message'];
  }
  
  return null;
}