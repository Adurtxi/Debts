import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final prefs = new UserPreferences();

  final userProvider = new UserProvider();

  bool darkMode = false;
  bool fingerprint = false;

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
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      value: darkMode,
                      title: Text('Modo oscuro'),
                      activeColor: Color.fromRGBO(31, 133, 109, 1.0),
                      onChanged: (value) => setState(() {
                        darkMode = value;
                      }),
                    ),
                    SwitchListTile(
                      value: fingerprint,
                      title: Text('Desbloqueo con huella'),
                      activeColor: Color.fromRGBO(31, 133, 109, 1.0),
                      onChanged: (value) => setState(() {
                        fingerprint = value;
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    _logout(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_outline),
                      Text("Cerrar Sesión"),
                    ],
                  ),
                ),
              ),
            ],
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
