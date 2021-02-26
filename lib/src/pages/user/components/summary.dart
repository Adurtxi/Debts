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
      height: 200,
      margin: EdgeInsets.only(top: 15),
      child: _carousel(quantity),
    );
  }

  Widget _carousel(List<double> quantity) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        Widget widget = (index == 0) ? _firstItem(quantity) : _secondItem(quantity);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: widget,
        );
      },
    );
  }

  Widget _firstItem(quantity) {
    double debtsTotalQuantity = quantity[0] - quantity[1];

    String text;

    if (debtsTotalQuantity == 0) {
      text = 'No hay deuda';
    } else if (debtsTotalQuantity > 0) {
      text = 'Debe ' + debtsTotalQuantity.abs().toString() + '€';
    } else {
      text = 'Le debe ' + debtsTotalQuantity.abs().toString() + '€';
    }

    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _secondItem(quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Usted'),
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
