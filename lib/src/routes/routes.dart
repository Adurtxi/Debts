import 'package:flutter/material.dart';

import 'package:debts/src/pages/debts_page.dart';
import 'package:debts/src/pages/home_page.dart';
import 'package:debts/src/pages/auth_page.dart';
import 'package:debts/src/pages/config/introduction_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'debts': (BuildContext context) => DebtsPage(),
    'introduction': (BuildContext context) => IntroductionPage(),
    'auth': (BuildContext context) => AuthPage(),
  };
}
