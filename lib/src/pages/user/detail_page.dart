import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final prefs = new UserPreferences();

  UserModel user = new UserModel();

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: MyAppBar(
        title: Text('${user.name} ${user.surname}'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(),
    );
  }
}
