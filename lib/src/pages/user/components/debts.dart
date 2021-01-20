import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';
import 'package:debts/src/models/user_model.dart';

import 'package:debts/src/widgets/debt/debt_card.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';
import 'package:debts/src/widgets/utils/message.dart';

// ignore: must_be_immutable
class UserDebts extends StatelessWidget {
  final UserModel user;

  UserDebts({@required this.user});

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
          builder: (context, state) => (state.userDebtsState == 0)
              ? LoaderW(size: 50)
              : (state.userDebtsState == -1)
                  ? ErrorW()
                  : RefreshIndicator(
                      color: Colors.black,
                      onRefresh: () async => debtBloc.add(
                        DebtsUserLoad(user.id),
                      ),
                      child: _debts(debtBloc, state.userDebts),
                    ),
        ),
      ),
    );
  }

  Widget _debts(DebtBloc debtBloc, List<DebtModel> debts) {
    if (debts == null) {
      return Message(message: 'No teneis deudas');
    }

    return ListView.builder(
      itemCount: debts.length,
      itemBuilder: (context, index) => DebtCard(
        debt: debts[index],
      ),
    );
  }
}
