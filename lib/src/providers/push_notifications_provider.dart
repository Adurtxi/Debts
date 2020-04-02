import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _prefs = new UserPreferences();

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      _prefs.phoneId = token;
    });

    _firebaseMessaging.configure(
      onMessage: (info) async {},
      onLaunch: (info) async {},
      onResume: (info) async {},
    );
  }
}
