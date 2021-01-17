import 'package:flutter/material.dart';

import 'package:debts/src/models/user_model.dart';
import 'package:debts/src/preferences/user_preferences.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  UserCard({@required this.user});

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: () => print(1),
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
            trailing: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
