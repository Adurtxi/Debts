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

  Future<Map<String, dynamic>> loadFollowers(String pathUrl) async {
    final url = '$_apiUrl/followers/$pathUrl';

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

  Future<Map<String, dynamic>> loadFolloweds(String pathUrl) async {
    final url = '$_apiUrl/followeds/$pathUrl';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return {'ok': false, 'followeds': []};

    if (decodedData['status'] == 'success') {
      final List<FollowerModel> followeds = new List();

      decodedData['followeds'].forEach((followed) {
        final prodTemp = FollowerModel.fromJson(followed);
        followeds.add(prodTemp);
      });

      return {'ok': true, 'followeds': followeds};
    } else {
      return {'ok': false, 'followeds': []};
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

  Future<bool> deleteFollowed(int userId) async {
    final url = '$_apiUrl/follower/cancel-delete/$userId';

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

  Future<bool> acceptFollower(int userId) async {
    final url = '$_apiUrl/follower/accept/$userId';

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
    final url = '$_apiUrl/follower/delete/$userId';

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

  _returnData(resp) {
    final decodedData = json.decode(resp.body);

    if (decodedData['status'] == 'success') {
      return {'ok': true, 'message': decodedData['message']};
    } else {
      return {'ok': false, 'message': decodedData['message']};
    }
  }
}
