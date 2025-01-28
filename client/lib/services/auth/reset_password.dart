import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:travel_app/services/constants/server_uri.dart';
import 'package:travel_app/services/response_data.dart';
import 'package:travel_app/services/get_csrf_token.dart';

Future<String?> resetPassword(Map<String, String> updatedUserDetails) async {
  try {
    // get csrf token
    final ResponseData tokenResponse = await getCsrfToken();

    if (!tokenResponse.success) {
      return tokenResponse.message;
    }

    String csrfToken = tokenResponse.data!['csrfToken'];
    
    // FIXME: address 'All fields are required' error
    final response = await http.post(
      Uri.parse('$serverUri/change-password/'), // api endpoint for changing password
      headers: {
        'Cookie': 'csrftoken=$csrfToken', 
        'X-CSRFToken': csrfToken,
      },
      body: jsonEncode({
        'email': updatedUserDetails['email'] ?? '',
        'new_password': updatedUserDetails['newPassword'] ?? '',
        'confirm_password': updatedUserDetails['confirmNewPassword'] ?? '',
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