import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/debt_card.dart';
import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/debt/floating_button.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';

class DebtsPage extends StatefulWidget {
  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  @override
  void initState() {
    super.initState();
    _loadDebts();
  }

  _loadDebts() async {
    BlocProvider.of<DebtBloc>(context).add(DebtsAllLoad());
  }

  List<DebtModel> debts = [];

  @override
  Widget build(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Deudas',
      ),
      body: _body(context, debtBloc),
      floatingActionButton: FloatingButtonDebt(),
    );
  }

  Widget _body(BuildContext context, DebtBloc debtBloc) {
    return Container(
      child: _container(context, debtBloc),
    );
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return BlocListener<DebtBloc, DebtState>(
      listener: (context, state) => (state.allDebtsState == 1) ? debts = state.allDebts : null,
      child: BlocBuilder<DebtBloc, DebtState>(
        builder: (context, state) => (state.allDebtsState == 0)
            ? LoaderW()
            : (state.allDebtsState == -1)
                ? ErrorW()
                : _debts(debtBloc, debts),
      ),
    );
  }

  Widget _debts(DebtBloc debtBloc, List<DebtModel> debts) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async => debtBloc.add(DebtsAllLoad()),
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
