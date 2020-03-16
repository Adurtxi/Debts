import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:flutter/material.dart';

class AppBarW extends StatefulWidget {
  final String title;

  const AppBarW({Key key, this.title}) : super(key: key);

  @override
  _AppBarWState createState() => _AppBarWState();
}

class _AppBarWState extends State<AppBarW> {
  final userProvider = new UserProvider();
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        _dropDown(),
      ],
    );
  }

  Widget _dropDown() {
    final items = <String>['Ayuda', 'Cuenta', 'Cerrar Sesión'];
    final userText = '${prefs.identity[1][0]}${prefs.identity[2][0]}';

    return DropdownButton<String>(
      style: TextStyle(color: Colors.black),
      underline: Container(
        child: CircleAvatar(
          child: Text(userText),
          backgroundColor: Colors.blue,
        ),
      ),
      onChanged: (String newValue) {
        setState(() {
          switch (newValue) {
            case 'Ayuda':
              Navigator.pushReplacementNamed(context, 'help');
              break;
            case 'Cuenta':
              Navigator.pushReplacementNamed(context, 'account');
              break;
            case 'Cerrar Sesión':
              _logout();
              break;
          }
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Column(
            children: <Widget>[
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }

  _logout() {
    userProvider.logout();

    Navigator.pushReplacementNamed(context, 'login');
  }
}
