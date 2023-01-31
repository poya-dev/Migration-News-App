import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<String> googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final signInAccount = await googleSignIn.signIn();
      if (signInAccount != null) {
        final auth = await signInAccount.authentication;
        return auth.idToken!;
      }
    } catch (e) {
      throw Exception('Sign up with Google is failed');
    }
    throw Exception('Sign up with Google is failed');
  }
}
