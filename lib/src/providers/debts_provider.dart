import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:epbasic_debts/src/preferences/user_preferences.dart';

import 'package:epbasic_debts/src/models/debt_model.dart';

class DebtsProvider {
  final String _url = 'https://api.debts.epbasic.eu/api';
  final _prefs = new UserPreferences();

  Future<bool> createDebt(DebtModel debt) async {
    print(debtModelToJson(debt));

    final url = '$_url/debt';

    final resp = await http.post(
      Uri.encodeFull(url),
      body: debtModelToJson(debt),
      headers: {HttpHeaders.authorizationHeader: _prefs.token},
    );

    //final decodedData = json.decode(resp.body);
    print(resp.body);
    return true;
  }

  Future<List<DebtModel>> loadDebts() async {
    final url = '$_url/debts';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    final List<DebtModel> debts = new List();

    decodedData.forEach((debts, debt) {
      final prodTemp = DebtModel.fromJson(debt);

      //debts.add(prodTemp);
    });

    return debts;
  }

  Future<bool> updateDebt(DebtModel debt) async {
    final url = '$_url/debt/${debt.id}';

    final resp = await http.put(
      url,
      body: debtModelToJson(debt),
    );

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<bool> deleteDebt(String id) async {
    final url = '$_url/debt/$id';

    final resp = await http.delete(url);

    final decodedData = json.decode(resp.body);

    return true;
  }
}
