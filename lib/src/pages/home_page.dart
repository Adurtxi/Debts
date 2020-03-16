import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/widgets/appbar.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userProvider = new UserProvider();
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            AppBarW(title: 'Inicio'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: <Widget>[
                  _cardType1(),
                  _cardType1(),
                  _cardType1(),
                  _cardType1(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  Widget _cardType1() {
    return Dismissible(
      //Eliminar producto
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {},
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Soy una tarjeta muy feliz'),
                subtitle: Text('Tengo cuatro curvas de 20'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
