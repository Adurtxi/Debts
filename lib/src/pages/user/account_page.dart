import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _prefs = new UserPreferences();

  String _password = '';

  final userProvider = new UserProvider();

  bool darkMode = false;
  bool fingerprint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Cuenta'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              _optionsCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: _logoutButton(),
    );
  }

  Widget _optionsCard() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              value: _prefs.lookScreen,
              title: Text('Pantalla de bloqueo'),
              activeColor: Color.fromRGBO(31, 133, 109, 1.0),
              onChanged: (value) => setState(() {
                _prefs.lookScreen = value;

                if (value == true) {
                  _prefs.lastPage = 'auth';
                } else {
                  _prefs.lastPage = 'home';
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _createInputPassword(),
            ),
            _changePass(),
          ],
        ),
      ),
    );
  }

  Widget _changePass() {
    return Container(
      margin: EdgeInsets.fromLTRB(100, 0, 100, 15),
      child: FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          _prefs.pincode = _password;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Cambiar PIN"),
          ],
        ),
      ),
    );
  }

  Widget _createInputPassword() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(),
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Introduce un PIN',
          labelText: 'Pin',
          suffixIcon: Icon(Icons.lock_open),
        ),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
      ),
    );
  }

  Widget _logoutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red),
          ),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            _logout(context);
          },
          child: Text("Cerrar Sesión"),
        ),
      ],
    );
  }

  _logout(context) {
    userProvider.logout();

    Navigator.pushReplacementNamed(context, 'login');
  }
}
