import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  static Future<String> facebookSignIn() async {
    const scope = ['public_profile', 'email'];
    final loginResult = await FacebookAuth.instance.login(permissions: scope);
    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      return accessToken.token;
    }
    if (loginResult.status == LoginStatus.cancelled) {
      throw Exception('User cancelled facebook Sign In');
    }
    throw Exception('Something went wrong with facebook Sign In');
  }

  static Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }
}
