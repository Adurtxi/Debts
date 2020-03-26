import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/modals/debt_actions_modal.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class DebstList extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final DebtModel debt;
  final String user;

  DebstList({@required this.debt, @required this.user});

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    DebtActionsModal modal = new DebtActionsModal(debt: debt);

    final debtsBloc = Provider.debtsBloc(context);

    final card = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'detail',
              arguments: debt,
            ),
            onLongPress: () => modal.mainBottomSheet(context),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  user,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              title: Text(debt.title),
              subtitle: Text(debt.description),
            ),
          ),
        ],
      ),
    );

    if (debt.userId == int.parse(prefs.identity[0])) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direction) async {
          Map info = await debtsBloc.deleteDebt(debt.id.toString());

          if (info['ok'] == true) {
            _printSnackbar(context, info['message']);
          } else {
            _printSnackbar(context, info['message']);
          }
        },
        child: card,
      );
    } else {
      return card;
    }
  }

  void _printSnackbar(context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
