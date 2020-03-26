import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:flutter/material.dart';

class DebtActionsModal {
  final DebtModel debt;

  DebtActionsModal({@required this.debt});

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Ver', Icons.attach_money, _detail),
              _createTile(context, 'Editar', Icons.mode_edit, _edit),
              _createTile(
                context,
                'Marcar como pagada',
                Icons.check,
                _markAsPaid,
              ),
            ],
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(context, debt);
      },
    );
  }

  _detail(BuildContext context, DebtModel debt) {
    Navigator.pushNamed(context, 'detail', arguments: debt);
  }

  _edit(BuildContext context, DebtModel debt) {
    Navigator.pushNamed(context, 'edit', arguments: debt);
  }

  _markAsPaid(BuildContext context, DebtModel debt) {}
}
