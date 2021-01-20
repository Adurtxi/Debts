import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/widgets/utils/error.dart';

import 'package:debts/src/models/user_model.dart';
import 'package:debts/src/models/debt_model.dart';

// ignore: must_be_immutable
class UserSummary extends StatelessWidget {
  final UserModel user;

  UserSummary({@required this.user});

  @override
  Widget build(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return _container(context, debtBloc);
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return BlocListener<DebtBloc, DebtState>(
      listener: (context, state) {},
      child: BlocBuilder<DebtBloc, DebtState>(
        builder: (context, state) =>
            (state.userDebtsState == -1) ? ErrorW() : _summary(state.userDebts),
      ),
    );
  }

  Widget _summary(List<DebtModel> debts) {
    List<double> quantity = [0.0, 0.0];

    if (debts != null) {
      debts.forEach((debt) {
        (debt.defaulterId == user.id) ? quantity[0] += debt.quantity : quantity[1] += debt.quantity;
      });
    }

    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 100,
      child: _row(quantity),
    );
  }

  Widget _row(List<double> quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Tú'),
            Text(
              quantity[0].toString() + ' €',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(user.name + ' ' + user.surname),
            Text(
              quantity[1].toString() + ' €',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
