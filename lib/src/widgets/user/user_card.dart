import 'package:flutter/material.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: () => _addUser(context, userBloc),
          child: ListTile(
            leading: Container(
              margin: EdgeInsets.all(7.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image(
                  image: NetworkImage(
                    user.image,
                  ),
                ),
              ),
            ),
            title: Text('${user.name} ${user.surname}'),
            trailing: _trailing(),
          ),
        ),
      ),
    );
  }

  Widget _trailing() {
    return (user.follower) ? Icon(Icons.remove) : Icon(Icons.add);
  }

  void _addUser(BuildContext context, UserBloc userBloc) {
    (user.follower)
        ? BlocProvider.of<UserBloc>(context).add(UserDelete(user.id))
        : BlocProvider.of<UserBloc>(context).add(UserAdd(user.id));
  }
}
