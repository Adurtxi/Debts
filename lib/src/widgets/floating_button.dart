import 'package:flutter/material.dart';

import 'package:debts/src/modals/create_debt.dart';

class FloatingButtonW extends StatelessWidget {
  const FloatingButtonW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        CreateDebtModal _aModal = CreateDebtModal();

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
