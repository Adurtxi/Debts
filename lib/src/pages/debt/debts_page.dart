import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:epbasic_debts/src/widgets/appbar.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  final debtsProvider = new DebtsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppBarW(title: 'Deudas'),
            Container(
              child: _createList(),
            ),
          ],
        ),
      ),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
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
  Widget _createItem(BuildContext context, DebtModel debt) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        debtsProvider.deleteDebt(debt.id.toString());
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
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

  //Botón crear nuevo producto
  _createButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "btn1",
          child: Icon(Icons.search),
          backgroundColor: Colors.black,
          onPressed: () {},
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          heroTag: "btn2",
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(31, 133, 109, 1.0),
          onPressed: () => Navigator.pushNamed(context, 'create'),
        ),
      ],
    );
  }
}
