import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class FollowedList extends StatelessWidget {
  final FollowerModel followed;

  FollowedList({@required this.followed});

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
              trailing: _trailing(_followersBloc),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailing(FollowersBloc _followersBloc) {
    if (followed.accepted == true) {
      return _flatButton('Eliminar', _followersBloc.deleteFollowed);
    } else {
      return _flatButton('Cancelar', _followersBloc.deleteFollowed);
    }
  }

  Widget _flatButton(String text, function) {
    return FlatButton(
      child: Text(text),
      onPressed: () => function(followed.followedId),
    );
  }
}
