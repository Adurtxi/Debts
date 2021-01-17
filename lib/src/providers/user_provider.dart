import 'dart:convert';

import 'package:debts/src/models/user_model.dart';
import 'package:debts/src/services/google_signin_service.dart';
import 'package:http/http.dart' as http;
import 'package:debts/src/preferences/user_preferences.dart';

class UserProvider {
  final _prefs = new UserPreferences();

  _setHeaders() => {'Content-type': 'application/json', 'Accept': 'application/json'};

  _setAuthHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<Map<String, dynamic>> googleSignIn(String token) async {
    final url = '${_prefs.url}/google-sign-in';

    final data = {
      'token': token,
    };

    final resp = await http.post(
      Uri.encodeFull(url),
      body: json.encode(data),
      headers: _setHeaders(),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['type'] == 'login') {
      _prefs.lastPage = 'home';

      _prefs.token = decodedResp['token'];

      _prefs.id = decodedResp['identity']['sub'];

      return {'type': 'login'};
    } else {
      return {
        'type': 'register',
        'payload': decodedResp['payload'],
      };
    }
  }

  // Crear cuenta
  Future<Map<String, dynamic>> register(
      String googleId, String name, String surname, String email, String image) async {
    final url = '${_prefs.url}/register';

    final authData = {
      'google_id': googleId,
      'name': name,
      'surname': surname,
      'email': email,
      'image': image,
      'phoneId': _prefs.phoneId,
    };

    final resp = await http.post(
      Uri.encodeFull(url),
      body: json.encode(authData),
      headers: _setHeaders(),
    );

    return _returnData(resp, 'register');
  }

  _returnData(resp, type) {
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == 'success') {
      _prefs.token = decodedResp['token'];

      switch (type) {
        case 'register':
          _prefs.lastPage = 'introduction';
          break;

        case 'login':
          _prefs.lastPage = 'home';
          break;
      }

      _prefs.id = decodedResp['identity']['sub'];

      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  logout() {
    GoogleSignInService.signOut();

    _prefs.token = null;
    _prefs.lastPage = null;
    _prefs.lookScreen = null;
    _prefs.pincode = null;
  }
}
