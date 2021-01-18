import 'package:flutter/material.dart';

import 'package:debts/src/pages/auth_page.dart';
import 'package:debts/src/pages/config/introduction_page.dart';
import 'package:debts/src/pages/home/home_page.dart';
import 'package:debts/src/pages/debts/debts_page.dart';
import 'package:debts/src/pages/users/users_page.dart';
import 'package:debts/src/pages/users/user_page.dart';
import 'package:debts/src/pages/config/config_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'auth': (BuildContext context) => AuthPage(),
    'introduction': (BuildContext context) => IntroductionPage(),
    'home': (BuildContext context) => HomePage(),
    'debts': (BuildContext context) => DebtsPage(),
    'users': (BuildContext context) => UsersPage(),
    'user': (BuildContext context) => UserPage(),
    'config': (BuildContext context) => ConfigPage(),
  };
}
