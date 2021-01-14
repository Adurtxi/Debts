import 'package:flutter/material.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:debts/src/widgets/appbar.dart';

class DebtsPage extends StatefulWidget {
  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarW(
        title: 'Debts',
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Container(),
    );
  }
}
