import 'package:debts/src/providers/user_provider.dart';
import 'package:debts/src/widgets/slide_transition.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:debts/src/pages/config/introduction_page.dart';

import 'package:debts/src/services/google_signin_service.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final userProvider = UserProvider();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container(context),
    );
  }

  Widget _container(context) {
    final size = MediaQuery.of(context).size;

    Widget loader = Container();

    if (loading) {
      loader = Column(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: Text('Espera por favor...'),
          ),
        ],
      );
    }

    return Container(
      margin: EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/img/icon.png'),
                      width: size.width * 0.35,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Debts',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          loader,
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: _googleButton(context),
          )
        ],
      ),
    );
  }

  _googleButton(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      minWidth: double.infinity,
      height: 50,
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(FontAwesomeIcons.google, color: Colors.white),
          ),
          Text(
            'Iniciar sesión con Google',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
      onPressed: () => _signIn(context),
    );
  }

  _signIn(BuildContext context) async {
    final account = await GoogleSignInService.signInWithGoogle();

    if (account['status'] == 'success') {
      setState(() {
        loading = true;
      });

      final resp = await userProvider.googleSignIn(account['googleKey']);

      if (resp['payload'] == null) {
        return;
      }

      switch (resp['type']) {
        case 'register':
          Navigator.pushReplacement(
            context,
            SlideRightRoute(
              page: IntroductionPage(
                name: resp['payload']['given_name'],
                surname: resp['payload']['family_name'],
                image: resp['payload']['picture'],
                email: resp['payload']['email'],
                googleId: resp['payload']['sub'],
              ),
            ),
          );

          break;

        case 'login':
          Navigator.pushReplacementNamed(context, 'Home');
          break;
      }
    }
  }
}
