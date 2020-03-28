import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class FollowedList extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FollowerModel followed;

  FollowedList({@required this.followed});

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'userDetail',
              arguments: followed.followed,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${followed.followed.name[0]}${followed.followed.surname[0]}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              title: Text(
                  '${followed.followed.name} ${followed.followed.surname}'),
              trailing: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }
}
