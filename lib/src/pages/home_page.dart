import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/widgets/favorite_contacts.dart';
import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/debt_card.dart';
import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/floating_button.dart';

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
    BlocProvider.of<DebtBloc>(context).add(
      DebtsLoadEvent(),
    );
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
      floatingActionButton: FloatingButtonW(),
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
        listener: (context, state) => (state is DebtsLoadedState) ? debts = state.debts : null,
        child: BlocBuilder<DebtBloc, DebtState>(
            builder: (context, state) => (state is DebtsLoadingState)
                ? LoaderW()
                : (state is DebtsLoadedState)
                    ? _debts(debtBloc, debts)
                    : ErrorW()),
      ),
    );
  }

  Widget _debts(DebtBloc debtBloc, List<DebtModel> debts) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async => debtBloc.add(DebtsLoadEvent()),
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
