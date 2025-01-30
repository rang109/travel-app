import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:travel_app/services/constants/server_uri.dart';
import 'package:travel_app/services/response_data.dart';
import 'package:travel_app/services/get_csrf_token.dart';

Future<String?> login(Map<String, String> userDetails) async {
  try {
    // get csrf token
    final ResponseData tokenResponse = await getCsrfToken();

    if (!tokenResponse.success) {
      return tokenResponse.message;
    }

    String csrfToken = tokenResponse.data!['csrfToken'];
    
    final response = await http.post(
      Uri.parse('$serverUri/login/'), // api endpoint for login
      headers: {
        'Cookie': 'csrftoken=$csrfToken',
        'X-CSRFToken': csrfToken,
      },
      body: jsonEncode({
        'email': userDetails['email'] ?? '',
        'password': userDetails['password'] ?? '',
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