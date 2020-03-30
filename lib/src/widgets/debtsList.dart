import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/modals/debt_actions_modal.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class DebstList extends StatelessWidget {
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
            onLongPress: () {
              if (debt.userId.toString() == prefs.identity[0]) {
                modal.mainBottomSheet(context);
              } else {
                _printSnackbar(context, 'No eres el creador de la deuda',
                    Colors.blue, Colors.white);
              }
            },
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
              subtitle: Text(
                debt.description,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: _trailing(),
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
            _printSnackbar(
                context, info['message'], Colors.green, Colors.white);
          } else {
            _printSnackbar(context, info['message'], Colors.red, Colors.white);
          }
        },
        child: card,
      );
    } else {
      return card;
    }
  }

  Widget _trailing() {
    if (debt.userId.toString() == prefs.identity[0]) {
      return Icon(Icons.person);
    } else if (debt.paid == true) {
      return Icon(Icons.check);
    } else {
      int i = debt.quantity.truncate();

      if (debt.quantity == i) {
        return Text('${i.toString()}€');
      }

      return Text('${debt.quantity.toString()}€');
    }
  }

  void _printSnackbar(
      BuildContext context, String message, Color backColor, Color textColor) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      duration: Duration(milliseconds: 1500),
      backgroundColor: backColor,
    ));
  }
}
