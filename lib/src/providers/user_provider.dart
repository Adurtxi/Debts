import 'dart:convert';

import 'package:debts/src/models/user_model.dart';
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

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '${_prefs.url}/login';

    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.encodeFull(url),
      body: json.encode(authData),
      headers: _setHeaders(),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == 'success') {
      _prefs.token = decodedResp['token'];

      final identity = decodedResp['identity'];

      _prefs.id = identity.id;
      _prefs.lastPage = 'home';

      setPhoneId(_prefs.phoneId);

      return {'ok': true, 'token': decodedResp['token']};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(
      String email, String password, String name, String surname) async {
    final url = '${_prefs.url}/register';

    final authData = {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.encodeFull(url),
      body: json.encode(authData),
      headers: _setHeaders(),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['status'] == 'success') {
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResp['message']};
    }
  }

  Future<List<UserModel>> searchUser(String query) async {
    final url = '${_prefs.url}/users/search/$query';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setAuthHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    if (decodedData['status'] == 'success') {
      final List<UserModel> users = new List();

      decodedData['users'].forEach((user) {
        final prodTemp = UserModel.fromJson(user);
        users.add(prodTemp);
      });

      return users;
    } else {
      return [];
    }
  }

  void setPhoneId(String token) async {
    final url = '${_prefs.url}/user/phoneId/$token';

    await http.get(
      Uri.encodeFull(url),
      headers: _setAuthHeaders(),
    );
  }

  logout() {
    _prefs.token = null;
    _prefs.lastPage = null;
    _prefs.lookScreen = null;
    _prefs.pincode = null;
  }
}
