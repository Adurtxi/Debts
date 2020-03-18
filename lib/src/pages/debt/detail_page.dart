import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class DebtDetail extends StatelessWidget {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Detalle',
          style: TextStyle(color: Colors.black),
        ),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
      ),
      body: Container(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
