import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:epbasic_debts/src/preferences/user_preferences.dart';

class UserProvider {
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      'https://api.debts.epbasic.eu/api/login',
      body: json.encode(authData),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == 'success') {
      _prefs.token = decodedResp['token'];

      final identity = decodedResp['identity'];

      List<String> identityList = [
        '${identity['sub']}',
        identity['name'],
        identity['surname'],
        identity['email'],
      ];

      _prefs.identity = identityList;
      _prefs.lastPage = 'home';

      return {'ok': true, 'token': decodedResp['token']};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(
      String email, String password, String name, String surname) async {
    final authData = {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      'https://api.debts.epbasic.eu/api/register',
      body: json.encode(authData),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == 'success') {
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  logout() {
    _prefs.token = null;
    _prefs.lastPage = null;
  }
}
