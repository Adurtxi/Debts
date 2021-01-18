import 'package:flutter/material.dart';

import 'package:debts/src/providers/user_provider.dart';

class DrawerW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 100),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Debts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Deudas'),
            onTap: () => Navigator.pushReplacementNamed(context, 'debts'),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Usuarios'),
            onTap: () => Navigator.pushReplacementNamed(context, 'users'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => Navigator.pushReplacementNamed(context, 'config'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Salir'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  _logout(context) {
    UserProvider userProvider = new UserProvider();

    userProvider.logout();

    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, 'auth');
  }
}
