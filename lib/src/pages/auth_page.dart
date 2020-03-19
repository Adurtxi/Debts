import 'package:epbasic_debts/src/services/local_authentication.dart';
import 'package:epbasic_debts/src/services/service_locator.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Authentication'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('authenticate'),
          onPressed: () {
            _auth();
          },
        ),
      ),
    );
  }

  _auth() async {
    await _localAuth.authenticate();
    print(_localAuth.isAuthenticated);
  }
}
