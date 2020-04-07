import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';

import 'package:epbasic_debts/src/preferences/user_preferences.dart';

class HelpPage extends StatelessWidget {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Ayuda'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
