import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:debts/src/providers/user_provider.dart';

import 'package:debts/src/utils/utils.dart';

class IntroductionPage extends StatefulWidget {
  final String googleId;
  final String image;
  final String name;
  final String email;
  final String surname;

  IntroductionPage({
    this.googleId,
    this.name,
    this.surname,
    this.email,
    this.image,
  });

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String name;
  String surname;

  String affiliate;

  final _prefs = UserPreferences();

  final userProvider = UserProvider();

  final _formKey = GlobalKey<FormState>();

  final introKey = GlobalKey<IntroductionScreenState>();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name = widget.name;
    surname = widget.surname;

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return _container(pageDecoration);
  }

  // Páginas de la introducción
  _container(pageDecoration) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'Fractional shares',
          body: 'Instead of having to buy an entire share, invest any amount you want.',
          image: _buildImage('icon.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          bodyWidget: Container(
            child: _userForm(),
          ),
          decoration: pageDecoration,
        ),
      ],
      skip: Text(
        'Cancelar',
      ),
      onDone: () => _onIntroEnd(context),
      onSkip: () {
        _prefs.lastPage = 'auth';

        Navigator.pushReplacementNamed(context, 'auth');
      },
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      next: Icon(Icons.arrow_forward),
      done: Text(
        'Entendido',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xff3366ff),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Align(
        child: Image.asset('assets/img/$assetName', width: 250.0),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  // Formulario de nombre y apellido
  Widget _userForm() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SafeArea(child: Container(height: 100.0)),
              Column(
                children: <Widget>[
                  Text(
                    'Últimos pasos',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: _createName(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: _createSurname(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createName() {
    if (_nameController.text == '') {
      _nameController.text = widget.name;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.deepPurple,
          ),
          hintText: 'Jon',
          labelText: 'Nombre',
        ),
        onChanged: (value) => name = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingresa tu nombre';
          }
          return null;
        },
      ),
    );
  }

  Widget _createSurname() {
    if (_surnameController.text == '') {
      _surnameController.text = widget.surname;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _surnameController,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person_outline,
            color: Colors.deepPurple,
          ),
          hintText: 'Doe',
          labelText: 'Apellido',
        ),
        onChanged: (value) => surname = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingresa tu apellido';
          }
          return null;
        },
      ),
    );
  }

  // Crear usuario
  void _onIntroEnd(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    if (name.length >= 3 && surname.length >= 3) {
      Map info =
          await userProvider.register(widget.googleId, name, surname, widget.email, widget.image);

      if (info['ok']) {
        _prefs.lastPage = 'home';

        Navigator.pushReplacementNamed(context, 'home');
      }
      // Error al crear la cuenta o el usuario se está auto afiliando
      else {
        showAlert(context, info['message']);
      }
    }
  }
}
