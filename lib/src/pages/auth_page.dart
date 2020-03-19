import 'package:epbasic_debts/src/services/local_authentication.dart';
import 'package:epbasic_debts/src/services/service_locator.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _password = '';

  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EPBasic Deudas'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            _createInputPassword(),
            _authButton(1, 'Autentificar con Pin'),
            _authButton(2, 'Autentificar con Huella'),
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
          hintText: 'Contraseña de la persona',
          labelText: 'Contraseña',
          suffixIcon: Icon(Icons.lock_open),
          icon: Icon(Icons.lock),
        ),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
      ),
    );
  }

  Widget _authButton(int type, String text) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.blue),
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text(text),
      onPressed: () => _goHome(type),
    );
  }

   _goHome(type) async {
    bool goHome = false;
    if (type == 1) {
      String password = '2486';
      if (_password == password) {
        goHome = true;
      }
    } else {
      final auth = await _auth();

      if (auth == true) {
        goHome = true;
      }
    }
    if (goHome == true) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  _auth() async {
    return await _localAuth.authenticate();
  }
}
