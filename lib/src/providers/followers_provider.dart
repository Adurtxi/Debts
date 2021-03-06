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

  Future<List<FollowerModel>> loadFollowers() async {
    final url = '${_prefs.url}/followers';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return null;

    if (decodedData['status'] == 'success') {
      final List<FollowerModel> followers = [];

      decodedData['followers'].forEach((follower) {
        final prodTemp = FollowerModel.fromJson(follower);
        followers.add(prodTemp);
      });

      return followers;
    } else {
      return null;
    }
  }

  Future<String> addFollower(int userId) async {
    final url = '${_prefs.url}/follower';

    final resp = await http.post(
      Uri.encodeFull(url),
      body: json.encode({
        'user_id': userId,
      }),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  Future<String> deleteFollower(int userId) async {
    final url = '${_prefs.url}/follower/$userId';

    final resp = await http.delete(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  String _returnData(resp) {
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return 'error';

    return decodedData['status'];
  }
}
