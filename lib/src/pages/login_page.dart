import 'package:flutter/material.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/utils/utils.dart';

class LoginPage extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _loginForm(context),
        ],
      ),
    );
  }

  //Formulario login
  Widget _loginForm(context) {
    final bloc = Provider.userBloc(context);
    final size = MediaQuery.of(context).size;

    //Contenido desplazable
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 150.0)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * 0.85,
            //Tarjeta login

            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 20.0)),
                //Inputs formulario
                SizedBox(height: 40.0),
                _createEmail(bloc),
                SizedBox(height: 20.0),
                _createPassword(bloc),
                SizedBox(height: 20.0),
                _createButton(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿No tienes cuenta?'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
          ),
          //Margen inferior
          SizedBox(height: 20.0)
        ],
      ),
    );
  }

  //Input email
  Widget _createEmail(UserBloc bloc) {
    //Stream de email y contraseña
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
                color: Color.fromRGBO(31, 133, 109, 1.0),
              ),
              hintText: 'email@email.com',
              labelText: 'Email',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            //Al cambiar guardar los datos en el stream
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
                color: Color.fromRGBO(31, 133, 109, 1.0),
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
      stream: bloc.loginFormValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Container(
            child: Text('Entrar'),
          ),
          //Redondear el botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(31, 133, 109, 1.0),
          textColor: Colors.white,
          //Activar cuando hay informacíon en el snapshot
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  //Enviar datos al provider y en caso de OK redirigir a home
  _login(UserBloc bloc, BuildContext context) async {
    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok'] == true) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, info['message']);
    }
  }
}
