import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/pages/debt/create_page.dart';
import 'package:epbasic_debts/src/pages/debt/debts_page.dart';
import 'package:epbasic_debts/src/pages/debt/detail_page.dart';
import 'package:epbasic_debts/src/pages/help_page.dart';
import 'package:epbasic_debts/src/pages/user/account_page.dart';
import 'package:epbasic_debts/src/pages/user/people_page.dart';
import 'package:epbasic_debts/src/pages/register_page.dart';
import 'package:epbasic_debts/src/pages/login_page.dart';
import 'package:epbasic_debts/src/pages/home_page.dart';
import 'package:epbasic_debts/src/pages/auth_page.dart';
import 'package:epbasic_debts/src/pages/debt/edit_page.dart';
import 'package:epbasic_debts/src/pages/user/detail_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'register': (BuildContext context) => RegisterPage(),
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'debts': (BuildContext context) => DebtsPage(),
    'detail': (BuildContext context) => DebtDetail(),
    'create': (BuildContext context) => NewDebtPage(),
    'edit': (BuildContext context) => EditDebtPage(),
    'help': (BuildContext context) => HelpPage(),
    'account': (BuildContext context) => AccountPage(),
    'people': (BuildContext context) => PeoplePage(),
    'auth': (BuildContext context) => AuthPage(),
    'userDetail': (BuildContext context) => UserDetailPage(),
  };
}
