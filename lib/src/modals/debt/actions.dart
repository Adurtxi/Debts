import 'package:debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

class DebtActionsModal {
  DebtModel debt;

  final _prefs = UserPreferences();

  DebtActionsModal({@required this.debt});

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _createTile(
            context,
            'Ver',
            Icons.east,
            Colors.blue[700],
            _detail,
          ),
          _createTile(
            context,
            'Marcar como pagada',
            Icons.money_rounded,
            Colors.green[700],
            _markAsPaid,
          ),
          _createTile(
            context,
            'Eliminar',
            Icons.title,
            Colors.red[700],
            _delete,
          ),
        ],
      ),
    );
  }

  Widget _createTile(
      BuildContext context, String name, IconData icon, Color color, Function function) {
    if ((function == _delete || function == _markAsPaid) && _prefs.id == debt.defaulterId) {
      return Container();
    }

    // ignore: close_sinks
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(name),
      onTap: () {
        function(context, debtBloc);

        Navigator.pop(context);
      },
    );
  }

  void _detail(BuildContext context, DebtBloc debtBloc) {}

  void _markAsPaid(BuildContext context, DebtBloc debtBloc) {}

  void _delete(BuildContext context, DebtBloc debtBloc) {
    debtBloc.add(
      DebtDelete(debt.id),
    );
  }
}
