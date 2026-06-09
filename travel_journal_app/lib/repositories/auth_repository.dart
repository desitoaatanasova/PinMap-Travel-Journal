import '../models/user_profile.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String email, String password);
  Future<void> logout();
  Future<UserProfile?> getCurrentUser();
  Future<bool> isLoggedIn();
}
