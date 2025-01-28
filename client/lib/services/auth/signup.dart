import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:travel_app/services/response_data.dart';

import 'package:travel_app/services/constants/server_uri.dart';
import 'package:travel_app/services/get_csrf_token.dart';

Future<String?> signup(Map<String, String> userDetails) async {
  try {
    // get csrf token
    final ResponseData tokenResponse = await getCsrfToken();

    if (!tokenResponse.success) {
      return tokenResponse.message;
    }

    String csrfToken = tokenResponse.data!['csrfToken'];
    
    final response = await http.post(
      Uri.parse('$serverUri/register/'), // api endpoint for signup
      headers: {
        'Cookie': 'csrftoken=$csrfToken',
        'X-CSRFToken': csrfToken,
      },
      body: jsonEncode({
        'first_name': userDetails['firstName'] ?? '',
        'last_name': userDetails['lastName'] ?? '',
        'email': userDetails['email'] ?? '',
        'username': userDetails['username'] ?? '',
        'password1': userDetails['password'] ?? '',
        'password2': userDetails['confirmPassword'] ?? '',
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