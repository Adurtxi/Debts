import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/debtsList.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);
    debtsBloc.homeDebts();

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Inicio'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Container(
        child: _createList(debtsBloc),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  //Lista de deudas
  _createList(DebtsBloc debtsBloc) {
    return StreamBuilder(
      stream: debtsBloc.homeDebtsStream,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ok'] == true) {
            final debts = snapshot.data['debts'];
            return ListView.builder(
              itemCount: debts.length,
              itemBuilder: (context, i) {
                final user =
                    '${debts[i].user.name[0]}${debts[i].user.surname[0]}';

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
}
