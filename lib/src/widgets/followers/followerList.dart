import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
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
    final _followersBloc = Provider.followersBloc(context);

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
              arguments: follower.followed,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${follower.follower.name[0]}${follower.follower.surname[0]}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              title: Text(
                  '${follower.follower.name} ${follower.follower.surname}'),
              trailing: _trailing(_followersBloc),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailing(FollowersBloc _followersBloc) {
    if (follower.accepted == true) {
      return FlatButton(
        child: Text('Eliminar'),
        onPressed: () {
          _followersBloc.deleteFollower(follower.followerId);
        },
      );
    } else {
      return ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
            child: new Text('Cancelar'),
            onPressed: () {
              _followersBloc.deleteFollower(follower.followerId);
            },
          ),
          new FlatButton(
            child: new Text('Aceptar'),
            onPressed: () {
              _followersBloc.acceptFollower(follower.followerId);
            },
          ),
        ],
      );
    }
  }
}
