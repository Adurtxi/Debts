import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/search/search_delegate.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/debtsList.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);
    debtsBloc.debtsDebts();

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Deudas'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(
        child: _createList(debtsBloc),
      ),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
    );
  }

  //Lista de deudas
  _createList(DebtsBloc debtsBloc) {
    return StreamBuilder(
      stream: debtsBloc.debtsDebtsStream,
      builder: (BuildContext context, AsyncSnapshot<List<DebtModel>> snapshot) {
        final debts = snapshot.data;

        if (snapshot.hasData && debts.length > 0) {
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
          onPressed: () {
            showSearch(
              context: context,
              delegate: DataSearch(),
            );
          },
        ),
      ],
    );
  }
}
