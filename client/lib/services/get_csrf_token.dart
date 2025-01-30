import 'package:http/http.dart' as http; import 'dart:convert';

import 'package:travel_app/services/response_data.dart';

import 'package:travel_app/services/constants/server_uri.dart';

Future<ResponseData> getCsrfToken() async {
  try{
    final response = await http.get(
      Uri.parse('$serverUri/get-csrf-token/'),
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      return ResponseData(
        success: false,
        message: responseBody['message'],
      );
    }

    String? setCookie = response.headers['set-cookie'];
    if (setCookie == null) {
      return ResponseData(
        success: false,
        message: 'Failed to get CSRF token',
      );
    }

    String? csrfToken;
    List<String> cookies = setCookie.split(';');
    for (String cookie in cookies) {
      if (cookie.trim().startsWith('csrftoken=')) {
        csrfToken = cookie.split('=')[1];
        break;
      }
    }

    if (csrfToken == null) {
      return ResponseData(
        success: false,
        message: 'Failed to parse CSRF token',
      );
    }

    return ResponseData(
      success: true,
      message: 'CSRF token received',
      data: {
        'csrfToken': responseBody['csrf_token'],
      },
    );
  } catch (e) {
    return ResponseData(
      success: false,
      message: e.toString(),
    );
  }
}