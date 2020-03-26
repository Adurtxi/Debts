import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
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
    final user = '${debt.user.name[0]}${debt.user.surname[0]}';
    final defaulter = '${debt.defaulter.name[0]}${debt.defaulter.surname[0]}';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: <Widget>[
          _userList(
            user,
            '${debt.user.name} ${debt.user.surname}',
          ),
          _userList(
            defaulter,
            '${debt.defaulter.name} ${debt.defaulter.surname}',
          ),
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

  Widget _userList(String userIcon, String user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Text(
                userIcon,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            title: Text(user),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
