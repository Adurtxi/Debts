import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  UserCard({@required this.user});

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: GestureDetector(
        onTap: () => _addUser(context, userBloc),
        child: ListTile(
          leading: Container(
            margin: EdgeInsets.all(7.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image(
                image: NetworkImage(user.image),
              ),
            ),
          ),
          title: Text('${user.name} ${user.surname}'),
          trailing: _trailing(),
        ),
      ),
    );
  }

  Widget _trailing() {
    return (user.follower)
        ? Icon(FontAwesomeIcons.solidHeart, color: Colors.red)
        : Icon(FontAwesomeIcons.heart, color: Colors.red);
  }

  void _addUser(BuildContext context, UserBloc userBloc) {
    (user.follower)
        ? BlocProvider.of<UserBloc>(context).add(UserDelete(user.id))
        : BlocProvider.of<UserBloc>(context).add(UserAdd(user.id));
  }
}
