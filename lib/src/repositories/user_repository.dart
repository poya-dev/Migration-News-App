import '../models/user.dart';
import '../api/api.dart';

class UserRepository {
  Future<User> signInWithGoogle(String idToken) async {
    return await ApiService.signInWithGoogle(idToken);
  }

  Future<User> signInWithFacebook(String accessToken) async {
    return await ApiService.signInWithFacebook(accessToken);
  }

  Future<void> sendDeviceToken(String deviceToken) async {
    return await ApiService.sendDeviceToken(deviceToken);
  }
}
