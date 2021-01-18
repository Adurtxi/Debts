import 'package:debts/src/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

class DebtModal {
  final DebtModel debt;

  DebtModal({@required this.debt});

  mainBottomSheet(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => _container(context, debtBloc),
    );
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return StatefulBuilder(
      builder: (BuildContext context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _titleContainer(),
              _detailContainer(),
              _defaulterCard(debt.defaulter),
            ],
          ),
        );
      },
    );
  }

  Widget _titleContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        debt.title,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _detailContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(
        debt.description,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _defaulterCard(UserModel user) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: ListTile(
        leading: _leading(user),
        title: Text(user.name + ' ' + user.surname),
      ),
    );
  }

  Widget _leading(UserModel user) {
    return Container(
      margin: EdgeInsets.all(7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image(
          image: NetworkImage(user.image),
        ),
      ),
    );
  }
}
