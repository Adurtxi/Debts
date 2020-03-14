import 'package:flutter/material.dart';

//Almacenamiento TOKEN
import 'package:epbasic_debts/src/preferences/user_preferences.dart';

//Bloc de Login
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/routes/routes.dart';

void main() async {
  runApp(MyApp());

  //Cargar preferencias
  final prefs = new UserPreferences();
  await prefs.initPrefs();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        //No mostrar barra debug
        debugShowCheckedModeBanner: false,
        title: 'EPBasic Debts',
        initialRoute: 'login',
        routes: getAppRoutes(),
        //Estilos globales
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
      ),
    );
  }
}
