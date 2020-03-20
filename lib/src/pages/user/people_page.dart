import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Gente'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
