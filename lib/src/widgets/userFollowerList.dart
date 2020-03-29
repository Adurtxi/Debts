import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class UserFollowerList extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final UserModel user;

  UserFollowerList({@required this.user});

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final _followersBloc = Provider.followersBloc(context);

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
            trailing: _trailing(_followersBloc),
          ),
        ],
      ),
    );
  }

  Widget _trailing(FollowersBloc _followersBloc) {
    if (user.follStatus == 0) {
      return FlatButton(
        child: Text('Seguir'),
        onPressed: () {
          _followersBloc.newFollower(user.id);
        },
      );
    } else {
      return Icon(Icons.person);
    }
  }
}
