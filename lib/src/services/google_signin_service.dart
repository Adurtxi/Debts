import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();

      final googleKey = await account.authentication;

      return {
        'status': 'success',
        'account': account,
        'googleKey': googleKey.idToken,
      };
    } catch (e) {
      return {'status': 'error'};
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
