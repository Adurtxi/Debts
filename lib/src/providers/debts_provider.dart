import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:debts/src/preferences/user_preferences.dart';
import 'package:debts/src/models/debt_model.dart';

class DebtsProvider {
  final _prefs = new UserPreferences();

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '${_prefs.token}'
      };

  Future<List<DebtModel>> loadDebts(String pathUrl) async {
    final url = '${_prefs.url}/$pathUrl';

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

  Future<List<DebtModel>> searchDebt(String query) async {
    final url = '${_prefs.url}/debts/search/$query';

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

  Future<DebtModel> createDebt(DebtModel debt) async {
    final url = '${_prefs.url}/debt';

    final resp = await http.post(
      Uri.encodeFull(url),
      body: debtModelToJson(debt),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  Future<DebtModel> updateDebt(DebtModel debt) async {
    final url = '${_prefs.url}/debt/${debt.id}';

    final resp = await http.put(
      Uri.encodeFull(url),
      body: debtModelToJson(debt),
      headers: _setHeaders(),
    );

    return _returnData(resp);
  }

  Future<String> markAsPaid(int id) async {
    final url = '${_prefs.url}/debt/markAsPaid/$id';

    final resp = await http.get(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    return _returnStatus(resp);
  }

  Future<String> deleteDebt(int id) async {
    final url = '${_prefs.url}/debt/$id';

    final resp = await http.delete(
      Uri.encodeFull(url),
      headers: _setHeaders(),
    );

    final decodedData = json.decode(resp.body);

    return decodedData['status'];
  }

  _returnStatus(resp) {
    final decodedData = json.decode(resp.body);

    return decodedData['status'];
  }

  _returnData(resp) {
    final decodedData = json.decode(resp.body);

    if (decodedData['status'] == 'success') {
      return DebtModel.fromJson(decodedData['debt']);
    } else {
      return null;
    }
  }
}
