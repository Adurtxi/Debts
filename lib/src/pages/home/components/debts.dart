import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/widgets/debt/debt_card.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';
import 'package:debts/src/widgets/utils/message.dart';

// ignore: must_be_immutable
class HomeDebts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return _container(context, debtBloc);
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return Expanded(
      child: BlocListener<DebtBloc, DebtState>(
        listener: (context, state) {},
        child: BlocBuilder<DebtBloc, DebtState>(
          builder: (context, state) => (state.debtsState == 0)
              ? LoaderW(size: 50)
              : (state.debtsState == -1)
                  ? ErrorW()
                  : _debts(debtBloc, state.debts),
        ),
      ),
    );
  }

  Widget _debts(DebtBloc debtBloc, List<DebtModel> debts) {
    if (debts == null) {
      return Message(message: 'No tienes deudas');
    }

    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async => debtBloc.add(
        DebtsLoad(),
      ),
      child: ListView.builder(
        itemCount: debts.length,
        itemBuilder: (context, index) => DebtCard(
          debt: debts[index],
        ),
      ),
    );
  }
}
