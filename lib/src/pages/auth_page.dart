import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/services/local_authentication.dart';
import 'package:epbasic_debts/src/services/service_locator.dart';

import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _prefs = new UserPreferences();

  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EPBasic Deudas'),
      ),
      body: Container(
        child: _createInputPassword(),
      ),
      floatingActionButton: _button(),
    );
  }

  Widget _createInputPassword() {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.1,
        horizontal: size.width * 0.3,
      ),
      child: VerificationCodeInput(
        keyboardType: TextInputType.number,
        length: _prefs.pincode.length,
        textStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
        onCompleted: (String value) {
          if (value == _prefs.pincode) {
            Navigator.pushReplacementNamed(context, 'home');
          }
        },
      ),
    );
  }

  Widget _button() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.blue),
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text('Desbloqueo con huella'),
      onPressed: () => _fingerprintAuth(),
    );
  }

  _fingerprintAuth() async {
    bool auth = await _auth();

    if (auth == true) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  _auth() async {
    return await _localAuth.authenticate();
  }
}
