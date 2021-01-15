import 'package:debts/src/widgets/floating_button.dart';
import 'package:flutter/material.dart';

import 'package:debts/src/widgets/favorite_contacts.dart';
import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/debt_card.dart';
import 'package:debts/src/widgets/drawer.dart';

import 'package:debts/src/models/debt_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Inicio',
      ),
      body: _body(),
      floatingActionButton: FloatingButtonW(),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        children: <Widget>[
          FavoriteContacts(),
          _container(),
        ],
      ),
    );
  }
}

Widget _container() {
  final List<DebtModel> debts = [
    DebtModel(
      id: 1,
      quantity: 10000,
      title: 'Deuda de ESPAÑA',
      userId: 1,
      defaulterId: 1,
      description: '',
      paid: true,
      fileName: '',
    ),
    DebtModel(
      id: 1,
      quantity: 20,
      title: 'Compra Eroski',
      userId: 1,
      defaulterId: 1,
      description: '',
      paid: true,
      fileName: '',
    ),
    DebtModel(
      id: 1,
      quantity: 500,
      title: 'Vacaciones',
      userId: 1,
      defaulterId: 1,
      description: '',
      paid: true,
      fileName: '',
    ),
    DebtModel(
      id: 1,
      quantity: 30,
      title: 'Libro FOL',
      userId: 1,
      defaulterId: 1,
      description: '',
      paid: true,
      fileName: '',
    ),
    DebtModel(
      id: 1,
      quantity: 1,
      title: 'Carro Eroski',
      userId: 1,
      defaulterId: 1,
      description: '',
      paid: true,
      fileName: '',
    ),
  ];

  return Expanded(
    child: ListView.builder(
      itemCount: debts.length,
      itemBuilder: (context, index) => DebtCard(
        itemIndex: index,
        debt: debts[index],
        press: () {},
      ),
    ),
  );
}
