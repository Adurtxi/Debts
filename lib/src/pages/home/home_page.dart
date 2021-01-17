import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';
import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/pages/home/components/contacts.dart';
import 'package:debts/src/pages/home/components/debts.dart';

import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/debt/floating_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    BlocProvider.of<DebtBloc>(context).add(DebtsLoad());
    BlocProvider.of<UserBloc>(context).add(UserFollowersLoad());
  }

  @override
  Widget build(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Inicio',
      ),
      body: _body(context, debtBloc),
      floatingActionButton: FloatingButtonDebt(
        previousPage: 'home',
      ),
    );
  }

  Widget _body(BuildContext context, DebtBloc debtBloc) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        children: <Widget>[
          HomeContacts(),
          HomeDebts(),
        ],
      ),
    );
  }
}
