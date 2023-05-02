import 'dart:async';
import 'dart:convert';
import 'package:Objectives_Manager/data/store.dart';
import 'package:Objectives_Manager/exceptions/auth_exception.dart';
import 'package:Objectives_Manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logoutTime;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
    }

    Store.saveMap('userData', {
      'token': _token,
      'email': _email,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
    }).then((_) {
      _autoLogout();
      notifyListeners();
    });
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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
    }

    Store.saveMap('userData', {
      'token': _token,
      'email': _email,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
    }).then((_) {
      _autoLogout();
      notifyListeners();
    });
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

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _clearLogoutTimer() {
    _logoutTime?.cancel();
    _logoutTime = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final logoutTime = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTime = Timer(Duration(seconds: logoutTime ?? 0), logout);
  }
}
