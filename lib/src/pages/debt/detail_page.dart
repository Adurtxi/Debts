import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/userList.dart';
import 'package:flutter/material.dart';

class DebtDetail extends StatelessWidget {
  final prefs = new UserPreferences();

  DebtModel debt = new DebtModel();

  @override
  Widget build(BuildContext context) {
    debt = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _container(),
            ]),
          )
        ],
      ),
    );
  }

  Widget _container() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: <Widget>[
          UserList(user: debt.user),
          UserList(user: debt.defaulter),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Descripción: ${debt.description}'),
                      Text('Pagado: ${debt.paid.toString()}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppbar() {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 100.0,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          debt.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
