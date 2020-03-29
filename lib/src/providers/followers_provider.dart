import 'dart:convert';

import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:http/http.dart' as http;

import 'package:epbasic_debts/src/preferences/user_preferences.dart';

class FollowersProvider {
  final String _apiUrl = 'https://api.debts.epbasic.eu/api';
  final _prefs = new UserPreferences();

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<List<FollowerModel>> loadFollowers(String pathUrl) async {
    final url = '$_apiUrl/followers/$pathUrl';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    if (decodedData['status'] == 'success') {
      final List<FollowerModel> followers = new List();

      decodedData['followers'].forEach((follower) {
        final prodTemp = FollowerModel.fromJson(follower);
        followers.add(prodTemp);
      });

      return followers;
    } else {
      return [];
    }
  }

  Future<List<FollowerModel>> loadFolloweds(String pathUrl) async {
    final url = '$_apiUrl/followeds/$pathUrl';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    if (decodedData['status'] == 'success') {
      final List<FollowerModel> followeds = new List();

      decodedData['followeds'].forEach((followed) {
        final prodTemp = FollowerModel.fromJson(followed);
        followeds.add(prodTemp);
      });

      return followeds;
    } else {
      return [];
    }
  }

  Future<bool> newFollower(int userId) async {
    final url = '$_apiUrl/follower/new/$userId';

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

  Future<bool> acceptFollower(int followerId) async {
    final url = '$_apiUrl/follower/accept/$followerId';

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

  Future<bool> deleteFollower(int followerId) async {
    final url = '$_apiUrl/follower/delete/$followerId';

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
