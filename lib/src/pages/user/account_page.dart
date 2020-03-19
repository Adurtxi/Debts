import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final prefs = new UserPreferences();
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Cuenta',
          style: TextStyle(color: Colors.black),
        ),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            onPressed: () {
              _logout(context);
            },
            child: const Text('Cerrar Sesión', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  _logout(context) {
    userProvider.logout();

    Navigator.pushReplacementNamed(context, 'login');
  }
}
