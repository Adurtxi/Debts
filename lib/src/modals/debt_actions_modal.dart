import 'package:epbasic_debts/src/blocs/debts_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:flutter/material.dart';

class DebtActionsModal {
  final DebtModel debt;

  DebtActionsModal({@required this.debt});

  mainBottomSheet(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);

    Column column;

    if (debt.paid == true) {
      column = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _createTile(context, 'Ver', Icons.attach_money, _detail, debtsBloc),
          _createTile(context, 'Editar', Icons.mode_edit, _edit, debtsBloc),
        ],
      );
    } else {
      column = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _createTile(context, 'Ver', Icons.attach_money, _detail, debtsBloc),
          _createTile(context, 'Editar', Icons.mode_edit, _edit, debtsBloc),
          _createTile(context, 'Marcar como pagada', Icons.check, _markAsPaid,
              debtsBloc),
        ],
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return column;
      },
    );
  }

  ListTile _createTile(BuildContext context, String name, IconData icon,
      Function action, DebtsBloc debtsBloc) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(context, debt, debtsBloc);
      },
    );
  }

  _detail(BuildContext context, DebtModel debt) {
    Navigator.pushNamed(context, 'detail', arguments: debt);
  }

  _edit(BuildContext context, DebtModel debt) {
    Navigator.pushNamed(context, 'edit', arguments: debt);
  }

  _markAsPaid(BuildContext context, DebtModel debt, DebtsBloc debtsBloc) async {
    debtsBloc.markAsPaid(debt.id.toString());
  }
}
