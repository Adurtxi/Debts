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
          //Fondo parte superior
          _createBackground(context),
          //Tarjeta login
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    //Tamaño total
    final size = MediaQuery.of(context).size;

    //Contenedor solido
    final background = Container(
      //40 % del alto total
      height: size.height * 0.4,
      //100 % del ancho total
      width: double.infinity,
      decoration: BoxDecoration(
        //Gradiente de izquierda a derecha
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(22, 216, 169, 1.0),
            Color.fromRGBO(31, 133, 109, 1.0),
          ],
        ),
      ),
    );

    //Circulos del contenedor
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    //Devolver un stack (widget que permite poner widgets encima de el)
    return Stack(
      children: <Widget>[
        //Incluir el fondo
        background,
        //Incluir circulos
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        //Icono del fondo
        Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'Adur Marques',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Formulario login
  Widget _loginForm(context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    //Contenido desplazable
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 180.0)),
          Container(
            //Margenes y tamaño
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * 0.85,
            //Tarjeta login
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              //Sombra
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
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
  Widget _createEmail(LoginBloc bloc) {
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

  Widget _createPassword(LoginBloc bloc) {
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

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
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

  //Enviar datos al provider para enviarlos a Firebase y en caso de OK redirigir a home
  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok'] == true) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, info['message']);
    }
  }
}
