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

  get pincode {
    return _prefs.getString('pincode') ?? '0000';
  }

  set pincode(String value) {
    _prefs.setString('pincode', value);
  }

  get phoneId {
    return _prefs.getString('phoneId') ?? null;
  }

  set phoneId(String value) {
    _prefs.setString('phoneId', value);
  }

  get url {
    return _prefs.getString('url') ?? 'https://api.debts-v2.epbasic.eu/api';
  }
}
