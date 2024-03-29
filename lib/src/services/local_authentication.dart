import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class LocalAuthenticationService {
  final _auth = LocalAuthentication();

  bool isAuthenticated = false;

  Future authenticate() async {
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: 'Ponga el dedo en el lector',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      if (isAuthenticated) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
