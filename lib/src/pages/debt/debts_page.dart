import 'package:epbasic_debts/src/widgets/appbar.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppBarW(title: 'Deudas'),
          ],
        ),
      ),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
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
