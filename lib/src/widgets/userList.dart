import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final UserModel user;

  UserList({@required this.user});

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Text(
                '${user.name[0]}${user.surname[0]}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            title: Text('${user.name} ${user.surname}'),
            trailing: Icon(Icons.person),
            onTap: () => Navigator.pushNamed(
              context,
              'userDetail',
              arguments: user,
            ),
          ),
        ],
      ),
    );
  }
}
