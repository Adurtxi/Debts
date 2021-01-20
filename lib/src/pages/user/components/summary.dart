import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/widgets/utils/error.dart';

import 'package:debts/src/models/user_model.dart';

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
        builder: (context, state) => (state.userDebtsState == -1) ? ErrorW() : _summary(),
      ),
    );
  }

  Widget _summary() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 100,
      child: _row(),
    );
  }

  Widget _row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Tú'),
            Text(
              '25 €',
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
              '20 €',
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
