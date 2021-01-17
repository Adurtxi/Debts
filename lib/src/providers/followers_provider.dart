import 'dart:convert';

import 'package:debts/src/models/follower_model.dart';
import 'package:http/http.dart' as http;

import 'package:debts/src/preferences/user_preferences.dart';

class FollowersProvider {
  final _prefs = new UserPreferences();

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<Map<String, dynamic>> loadFollowers(String pathUrl) async {
    final url = '${_prefs.url}/followers/$pathUrl';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return {'ok': false, 'followers': []};

    if (decodedData['status'] == 'success') {
      final List<FollowerModel> followers = new List();

      decodedData['followers'].forEach((follower) {
        final prodTemp = FollowerModel.fromJson(follower);
        followers.add(prodTemp);
      });

      return {'ok': true, 'followers': followers};
    } else {
      return {'ok': false, 'followers': []};
    }
  }

  Future<bool> newFollower(int userId) async {
    final url = '${_prefs.url}/follower/new/$userId';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return false;

    if (decodedData['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFollower(int userId) async {
    final url = '${_prefs.url}/follower/delete/$userId';

    final resp = await http.delete(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return false;

    if (decodedData['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
