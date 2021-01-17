import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/widgets/favorite_contacts.dart';
import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/debt_card.dart';
import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/debt/floating_button.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadDebts();
  }

  _loadDebts() async {
    BlocProvider.of<DebtBloc>(context).add(DebtsLoad());
  }

  List<DebtModel> debts = [];

  @override
  Widget build(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Inicio',
      ),
      body: _body(context, debtBloc),
      floatingActionButton: FloatingButtonDebt(),
    );
  }

  Widget _body(BuildContext context, DebtBloc debtBloc) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        children: <Widget>[
          FavoriteContacts(),
          _container(context, debtBloc),
        ],
      ),
    );
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return Expanded(
      child: BlocListener<DebtBloc, DebtState>(
        listener: (context, state) => (state.debtsState == 1) ? debts = state.debts : null,
        child: BlocBuilder<DebtBloc, DebtState>(
          builder: (context, state) => (state.debtsState == 0)
              ? LoaderW()
              : (state.debtsState == -1)
                  ? ErrorW()
                  : _debts(debtBloc, debts),
        ),
      ),
    );
  }

  Widget _debts(DebtBloc debtBloc, List<DebtModel> debts) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async => debtBloc.add(DebtsLoad()),
      child: ListView.builder(
        itemCount: debts.length,
        itemBuilder: (context, index) => DebtCard(
          itemIndex: index,
          debt: debts[index],
          press: () => print(1),
        ),
      ),
    );
  }
}
