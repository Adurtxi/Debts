import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/widgets/appbar.dart';

import 'package:debts/src/models/user_model.dart';

import 'package:debts/src/pages/user/components/debts.dart';
import 'package:debts/src/pages/user/components/summary.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;

    BlocProvider.of<DebtBloc>(context).add(DebtsUserLoad(user.id));

    return Scaffold(
      appBar: AppBarW(
        title: user.name + ' ' + user.surname,
      ),
      body: _body(context, user),
    );
  }

  Widget _body(BuildContext context, UserModel user) {
    return Column(
      children: [
        UserSummary(user: user),
        UserDebts(user: user),
      ],
    );
  }
}
