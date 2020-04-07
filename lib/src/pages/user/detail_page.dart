import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _prefs = new UserPreferences();

  UserModel _user = new UserModel();

  @override
  Widget build(BuildContext context) {
    _user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: MyAppBar(
        title: Text('${_user.name} ${_user.surname}'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(),
    );
  }
}
