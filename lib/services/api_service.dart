import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:target_sistemas/helpers/input_formatter.dart';
import 'package:target_sistemas/services/user_service.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/';

  static Future<bool> login(
      String username, String password, BuildContext context) async {
    if (!InputFormatter.isLoginValid(username, context)) {
      return false;
    }

    if (!InputFormatter.isPasswordValid(password, context)) {
      return false;
    }

    final body = <String, String>{
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('${_baseUrl}auth/login'),
      body: body,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String responseToken = responseBody['token'];
      final String responseUsername = responseBody['username'];
      await UserService.setUser(responseUsername);
      await UserService.setToken(responseToken);
      return true;
    } else {
      return false;
    }
  }
}
