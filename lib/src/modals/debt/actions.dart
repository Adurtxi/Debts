import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/modals/debt/detail.dart';

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
            FontAwesomeIcons.eye,
            Colors.blue[700],
            _detail,
          ),
          _createTile(
            context,
            'Perfil',
            FontAwesomeIcons.userAlt,
            Colors.purple[700],
            _profile,
          ),
          _createTile(
            context,
            'Marcar como pagada',
            FontAwesomeIcons.moneyBill,
            Colors.green[700],
            _markAsPaid,
          ),
          _createTile(
            context,
            'Eliminar',
            FontAwesomeIcons.trash,
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
      leading: Icon(
        icon,
        color: color,
        size: 18,
      ),
      title: Text(name),
      onTap: () => function(context, debtBloc),
    );
  }

  void _profile(BuildContext context, DebtBloc debtBloc) {
    Navigator.pushReplacementNamed(context, 'user', arguments: debt.user);
  }

  void _detail(BuildContext context, DebtBloc debtBloc) {
    final DebtModal _dModal = DebtModal(debt: debt);

    _dModal.mainBottomSheet(context);
  }

  void _markAsPaid(BuildContext context, DebtBloc debtBloc) {
    debtBloc.add(
      DebtMarkAsPaid(debt.id),
    );

    Navigator.pop(context);
  }

  void _delete(BuildContext context, DebtBloc debtBloc) {
    debtBloc.add(
      DebtDelete(debt.id),
    );

    Navigator.pop(context);
  }
}
