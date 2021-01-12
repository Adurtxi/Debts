import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/search/debt_search_delegate.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/debtsList.dart';
import 'package:epbasic_debts/src/widgets/loader.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';

class DebtsPage extends StatelessWidget {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);
    debtsBloc.debtsDebts();

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Deudas'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _createList(debtsBloc),
          ),
          _loader(debtsBloc),
        ],
      ),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
    );
  }

  //Lista de deudas
  _createList(DebtsBloc debtsBloc) {
    return StreamBuilder(
      stream: debtsBloc.debtsDebtsStream,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ok'] == true) {
            final debts = snapshot.data['debts'];
            return ListView.builder(
              itemCount: debts.length,
              itemBuilder: (context, i) {
                final user = '${debts[i].user.name[0]}${debts[i].user.surname[0]}';

                return DebstList(debt: debts[i], user: user);
              },
            );
          } else {
            return Container();
          }
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
          heroTag: "create",
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              color: Colors.green[500],
            ),
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.add, color: Colors.white),
          ),
          onPressed: () => Navigator.pushNamed(context, 'create'),
        ),
        SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () {
            showSearch(context: context, delegate: DebtSearch());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              color: Color(0xFF1976D2),
            ),
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ],
    );
  }

  _loader(DebtsBloc debtsBloc) {
    return StreamBuilder(
      stream: debtsBloc.loadingStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == true) {
          return ProgressIndicatorW();
        }
        return Container();
      },
    );
  }
}
