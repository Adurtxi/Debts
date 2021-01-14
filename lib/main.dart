import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:debts/src/preferences/user_preferences.dart';

import 'package:debts/src/routes/routes.dart';

import 'package:debts/src/providers/push_notifications_provider.dart';
import 'package:debts/src/services/service_locator.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = new UserPreferences();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debts',
      initialRoute: _prefs.lastPage,
      routes: getAppRoutes(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Color(0xAFEF9EB),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
