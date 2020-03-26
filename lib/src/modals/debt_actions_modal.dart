import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:flutter/material.dart';

class DebtActionsModal {
  final DebtModel debt;

  DebtActionsModal({@required this.debt});

  mainBottomSheet(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(
                  context, 'Ver', Icons.attach_money, _detail, debtsBloc),
              _createTile(context, 'Editar', Icons.mode_edit, _edit, debtsBloc),
              _createTile(
                  context, 'Eliminar', Icons.delete, _delete, debtsBloc),
            ],
          );
        });
  }

  ListTile _createTile(BuildContext context, String name, IconData icon,
      Function action, DebtsBloc debtsBloc) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(context, debtsBloc, debt);
      },
    );
  }

  _detail(BuildContext context, DebtsBloc debtsBloc, DebtModel debt) {
    Navigator.pushNamed(context, 'detail', arguments: debt);
  }

  _edit(BuildContext context, DebtsBloc debtsBloc, DebtModel debt) {
    Navigator.pushNamed(context, 'create', arguments: debt);
  }

  _delete(BuildContext context, DebtsBloc debtsBloc, DebtModel debt) async {
    Map info = await debtsBloc.deleteDebt(debt.id.toString());

    if (info['ok'] == true) {
      _printSnackbar(context, info['message']);
    } else {
      _printSnackbar(context, info['message']);
    }
  }

  void _printSnackbar(context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
