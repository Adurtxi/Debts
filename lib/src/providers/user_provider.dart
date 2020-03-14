import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:epbasic_debts/src/preferences/user_preferences.dart';

class UserProvider {
  final String _firebaseToken = 'AIzaSyDQXvtvjskMB6Pxi1wBsuNNnuY7heFcftI';
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return _returnDecodedData(decodedResp);
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return _returnDecodedData(decodedResp);
  }

  _returnDecodedData(decodedResp) {
    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {
        'ok': true,
        'token': decodedResp['idToken'],
      };
    } else {
      return {
        'ok': false,
        'message': decodedResp['error']['message'],
      };
    }
  }
}
