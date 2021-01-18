import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/modals/debt/create.dart';

import 'package:debts/src/models/follower_model.dart';

class FollowerActionsModal {
  FollowerModel followed;

  FollowerActionsModal({@required this.followed});

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
            'Eliminar',
            FontAwesomeIcons.heartBroken,
            Colors.red[700],
            _delete,
          ),
          _createTile(
            context,
            'Crear deuda',
            FontAwesomeIcons.moneyBill,
            Colors.green[700],
            _createDebt,
          ),
        ],
      ),
    );
  }

  Widget _createTile(
      BuildContext context, String name, IconData icon, Color color, Function function) {
    // ignore: close_sinks
    final userBloc = BlocProvider.of<UserBloc>(context);

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 18,
      ),
      title: Text(name),
      onTap: () {
        function(context, userBloc);
      },
    );
  }

  void _delete(BuildContext context, UserBloc userBloc) {
    userBloc.add(
      FollowerDelete(followed.followedId, 'home'),
    );

    Navigator.pop(context);
  }

  void _createDebt(BuildContext context, UserBloc userBloc) {
    CreateDebtModal _dModal = CreateDebtModal(previousPage: 'home');

    _dModal.mainBottomSheet(context);
  }
}
