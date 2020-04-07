import 'package:epbasic_debts/src/providers/push_notifications_provider.dart';
import 'package:epbasic_debts/src/services/service_locator.dart';
import 'package:flutter/material.dart';

//Almacenamiento TOKEN
import 'package:epbasic_debts/src/preferences/user_preferences.dart';

//Bloc de Login
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/routes/routes.dart';

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
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = new UserPreferences();

    _prefs.actualPage = 0;

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EPBasic Debts',
        initialRoute: _prefs.lastPage,
        routes: getAppRoutes(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.black,
          primaryColorBrightness: Brightness.dark,
          primaryColorLight: Colors.black,
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
          indicatorColor: Colors.white,
          canvasColor: Colors.black,
        ),
      ),
    );
  }
}
