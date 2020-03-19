import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:flutter/material.dart';

class DebstList extends StatelessWidget {
  final DebtModel debt;
  final String user;

  DebstList({@required this.debt, @required this.user});

  final debtsProvider = new DebtsProvider();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        debtsProvider.deleteDebt(debt.id.toString());
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text(user),
                backgroundColor: Colors.blue,
              ),
              title: Text('${debt.title}'),
              subtitle: Text(debt.id.toString()),
              onTap: () => Navigator.pushNamed(
                context,
                'detail',
                arguments: debt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
