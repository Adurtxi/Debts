import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:flutter/material.dart';

class DebstList extends StatelessWidget {
  final DebtModel debt;

  DebstList({@required this.debt});

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
                child: Text('NS'),
                backgroundColor: Colors.blue,
              ),
              title: Text('${debt.title}'),
              subtitle: Text(debt.id.toString()),
              onTap: () => Navigator.pushNamed(
                context,
                'debt',
                arguments: debt,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Lista de deudas
  _createList() {
    return FutureBuilder(
      future: debtsProvider.loadDebts(),
      builder: (BuildContext context, AsyncSnapshot<List<DebtModel>> snapshot) {
        if (snapshot.hasData) {
          final debts = snapshot.data;

          return ListView.builder(
            itemCount: debts.length,
            itemBuilder: (context, i) => _createItem(context, debts[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Widget de cada debt
  Widget _createItem(BuildContext context, DebtModel debt) {}
}
