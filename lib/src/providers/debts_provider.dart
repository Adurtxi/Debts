import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:epbasic_debts/src/preferences/user_preferences.dart';

import 'package:epbasic_debts/src/models/debt_model.dart';

class DebtsProvider {
  final String _url = 'https://api.debts.epbasic.eu/api';
  final _prefs = new UserPreferences();

  Future<bool> createDebt(DebtModel debt) async {
    final url = '$_url/Debts.json?auth=${_prefs.token}';

    final resp = await http.post(
      url,
      body: debtModelToJson(debt),
    );

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<List<DebtModel>> loadDebts() async {
    final url = '$_url/debts';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    final List<DebtModel> Debts = new List();

    decodedData.forEach((debts, debt) {
      final prodTemp = DebtModel.fromJson(debt);
      prodTemp.id = debt.id;
      Debts.add(prodTemp);
    });

    return Debts;
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
