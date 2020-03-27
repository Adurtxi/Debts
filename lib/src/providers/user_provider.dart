import 'dart:convert';

import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:epbasic_debts/src/preferences/user_preferences.dart';

class UserProvider {
  final _prefs = new UserPreferences();

  final String _apiUrl = 'https://api.debts.epbasic.eu/api';

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};

  _setAuthHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '$_apiUrl/login';

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
    final url = '$_apiUrl/register';

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
    final url = '$_apiUrl/users/search/$query';

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

  logout() {
    _prefs.token = null;
    _prefs.lastPage = null;
    _prefs.lookScreen = null;
  }
}
