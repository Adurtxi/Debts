import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class FollowerList extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FollowerModel follower;

  FollowerList({@required this.follower});

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
                '${follower.follower.name[0]}${follower.follower.surname[0]}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            title:
                Text('${follower.follower.name} ${follower.follower.surname}'),
            trailing: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
