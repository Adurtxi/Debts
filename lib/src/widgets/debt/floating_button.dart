import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/modals/debt/create.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

class FloatingButtonDebt extends StatelessWidget {
  final previousPage;

  const FloatingButtonDebt({Key key, @required this.previousPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<UserBloc>(context).add(
          UserRemoveSelect(),
        );

        CreateDebtModal _aModal = CreateDebtModal(previousPage: previousPage);

        _aModal.mainBottomSheet(context);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    );
  }
}
