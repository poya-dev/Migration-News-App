import '../models/user.dart';
import '../api/api.dart';

class UserRepository {
  Future<User> signInWithGoogle(String idToken) async {
    return await ApiService.signInWithGoogle(idToken);
  }

  Future<User> signInWithFacebook(String accessToken) async {
    return await ApiService.signInWithFacebook(accessToken);
  }
}
