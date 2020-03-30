import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:epbasic_debts/src/preferences/user_preferences.dart';

import 'package:epbasic_debts/src/models/debt_model.dart';

class DebtsProvider {
  final String _apiUrl = 'https://api.debts.epbasic.eu/api';
  final _prefs = new UserPreferences();

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<Map<String, dynamic>> loadDebts(String pathUrl) async {
    final url = '$_apiUrl/$pathUrl';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return {'ok': false, 'debts': []};

    if (decodedData['status'] == 'success') {
      final List<DebtModel> debts = new List();

      decodedData['debts'].forEach((debt) {
        final prodTemp = DebtModel.fromJson(debt);
        debts.add(prodTemp);
      });

      return {'ok': true, 'debts': debts};
    } else {
      return {'ok': false, 'debts': []};
    }
  }

  Future<List<DebtModel>> searchDebt(String query) async {
    final url = '$_apiUrl/debts/search/$query';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    if (decodedData['status'] == 'success') {
      final List<DebtModel> debts = new List();

      decodedData['debts'].forEach((debt) {
        final prodTemp = DebtModel.fromJson(debt);
        debts.add(prodTemp);
      });

      return debts;
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> createDebt(DebtModel debt) async {
    final url = '$_apiUrl/debt';

    final resp = await http.post(
      Uri.encodeFull(url),
      body: debtModelToJson(debt),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  Future<Map<String, dynamic>> updateDebt(DebtModel debt) async {
    final url = '$_apiUrl/debt/${debt.id}';

    final resp = await http.put(
      Uri.encodeFull(url),
      body: debtModelToJson(debt),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  Future<Map<String, dynamic>> deleteDebt(String id) async {
    final url = '$_apiUrl/debt/$id';

    final resp = await http.delete(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    return _returnData(resp);
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
