import 'package:flutter/material.dart';

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
            leading: Icon(Icons.message),
            title: Text('Deudas'),
            onTap: () => Navigator.pushNamed(context, 'debts'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfíl'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Salir'),
          ),
        ],
      ),
    );
  }
}
