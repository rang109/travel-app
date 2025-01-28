import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:travel_app/services/constants/server_uri.dart';
import 'package:travel_app/services/response_data.dart';
import 'package:travel_app/services/get_csrf_token.dart';

Future<String?> verifyEmail(String otp, String emailAddress) async {
  try {
    // get csrf token
    final ResponseData tokenResponse = await getCsrfToken();

    if (!tokenResponse.success) {
      return tokenResponse.message;
    }

    String csrfToken = tokenResponse.data!['csrfToken'];
    
    final response = await http.post(
      Uri.parse('$serverUri/verify-email/$emailAddress/'), // api endpoint for verify email
      headers: {
        'Cookie': 'csrftoken=$csrfToken',
        'X-CSRFToken': csrfToken,
      },
      body: jsonEncode({
        'otp_code': otp,
      }),
    );

    if (response.statusCode >= 400) {
      return jsonDecode(response.body)['message'];
    }

    return null;
  } catch (e) {
    return e.toString();
  }
}