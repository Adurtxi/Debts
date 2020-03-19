import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get identity {
    return _prefs.getStringList('identity') ?? '';
  }

  set identity(List value) {
    _prefs.setStringList('identity', value);
  }

  get lastPage {
    return _prefs.getString('lastPage') ?? 'login';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }

  get lookScreen {
    return _prefs.getBool('lookScreen') ?? false;
  }

  set lookScreen(bool value) {
    _prefs.setBool('lookScreen', value);
  }

  get darkMode {
    return _prefs.getBool('darkMode') ?? false;
  }

  set darkMode(bool value) {
    _prefs.setBool('darkMode', value);
  }
}
