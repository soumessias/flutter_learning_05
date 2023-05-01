import 'dart:convert';
import 'package:Objectives_Manager/exceptions/auth_exception.dart';
import 'package:Objectives_Manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  Future<void> signUp(String email, String password) async {
    final response = await post(
      Uri.parse(Constants.SIGN_UP_URL),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    print(jsonDecode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    final response = await post(
      Uri.parse(Constants.SIGN_IN_URL),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    print(jsonDecode(response.body));
  }

  Future<void> recoveryPassword(String email) async {
    final response = await post(
      Uri.parse(Constants.RECOVERY_PASS_URL),
      body: jsonEncode({
        'email': email,
        'requestType': 'PASSWORD_RESET',
      }),
    );

    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    print(jsonDecode(response.body));
  }
}
