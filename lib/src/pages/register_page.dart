import 'package:flutter/material.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/utils/utils.dart';

class RegisterPage extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(context) {
    final bloc = Provider.userBloc(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 90.0)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * 0.85,
            child: Column(
              children: <Widget>[
                Text(
                  'Registro',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 40.0),
                _createName(bloc),
                SizedBox(height: 20.0),
                _createSurname(bloc),
                SizedBox(height: 20.0),
                _createEmail(bloc),
                SizedBox(height: 20.0),
                _createPassword(bloc),
                SizedBox(height: 20.0),
                _createButton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text('Ya tienes cuenta'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _createName(UserBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
              hintText: 'Jon',
              labelText: 'Nombre',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeName,
          ),
        );
      },
    );
  }

  Widget _createSurname(UserBloc bloc) {
    return StreamBuilder(
      stream: bloc.surnameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.person_outline,
                color: Colors.deepPurple,
              ),
              hintText: 'Brown',
              labelText: 'Apellido',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeSurname,
          ),
        );
      },
    );
  }

  Widget _createEmail(UserBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'email@email.com',
              labelText: 'Email',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassword(UserBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              hintText: '******',
              labelText: 'Contraseña',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(UserBloc bloc) {
    return StreamBuilder(
      stream: bloc.registerFormValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Container(
            child: Text('Entrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.purple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(UserBloc bloc, BuildContext context) async {
    final info = await userProvider.newUser(
        bloc.email, bloc.password, bloc.name, bloc.surname);

    if (info['ok'] == true) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      showAlert(context, info['message']);
    }
  }
}
