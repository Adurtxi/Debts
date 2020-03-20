import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/debtsList.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  final debtsProvider = new DebtsProvider();
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Deudas'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(
        child: _createList(),
      ),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
    );
  }

  //Lista de deudas
  _createList() {
    return FutureBuilder(
      future: debtsProvider.loadDebts('debts'),
      builder: (BuildContext context, AsyncSnapshot<List<DebtModel>> snapshot) {
        if (snapshot.hasData) {
          final debts = snapshot.data;

          return ListView.builder(
            itemCount: debts.length,
            itemBuilder: (context, i) {
              final user =
                  '${debts[i].user.name[0]}${debts[i].user.surname[0]}';

              return DebstList(debt: debts[i], user: user);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Botón crear nuevo producto
  _createButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "btn2",
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromRGBO(31, 133, 109, 1.0),
          onPressed: () => Navigator.pushNamed(context, 'create'),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          heroTag: "btn1",
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onPressed: () {},
        ),
      ],
    );
  }
}
