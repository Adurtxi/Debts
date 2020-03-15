import 'package:epbasic_debts/src/widgets/appbar.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            AppBarW(title: 'Deudas'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
