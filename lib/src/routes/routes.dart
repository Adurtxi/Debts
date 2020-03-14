import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/pages/register_page.dart';
import 'package:epbasic_debts/src/pages/login_page.dart';
import 'package:epbasic_debts/src/pages/home_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'register': (BuildContext context) => RegisterPage(),
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
  };
}
