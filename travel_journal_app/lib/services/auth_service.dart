import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class AuthService {
  static UserProfile? _currentUser;
  static bool _isLoggedIn = false;

  static bool get isLoggedIn => _isLoggedIn;
  static UserProfile? get currentUser => _currentUser;

  static Future<bool> login(String username, String password) async {
    try {
      final data = await ApiClient.post('/auth/login', body: {
        'username': username,
        'password': password,
      }, auth: false);
      await ApiClient.setToken(data['token']);
      final u = data['user'];
      _currentUser = UserProfile(
        username: u['username'] ?? '',
        firstName: u['firstName'],
        lastName: u['lastName'],
        profilePicture: u['profilePicture'],
        bio: u['bio'] ?? '',
        profileStatus: u['profileStatus'] ?? 'public',
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      _isLoggedIn = false;
      return false;
    }
  }

  static Future<bool> register(String username, String email, String password, {String? firstName, String? lastName}) async {
    try {
      final data = await ApiClient.post('/auth/register', body: {
        'username': username,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      }, auth: false);
      await ApiClient.setToken(data['token']);
      final u = data['user'];
      _currentUser = UserProfile(
        username: u['username'] ?? '',
        firstName: u['firstName'],
        lastName: u['lastName'],
        profilePicture: u['profilePicture'],
        bio: '',
        profileStatus: u['profileStatus'] ?? 'public',
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      _isLoggedIn = false;
      return false;
    }
  }

  static Future<void> logout() async {
    await ApiClient.clearToken();
    _currentUser = null;
    _isLoggedIn = false;
  }

  static Future<UserProfile?> getCurrentUser() async {
    try {
      final data = await ApiClient.get('/auth/me');
      _currentUser = UserProfile(
        username: data['username'] ?? '',
        firstName: data['first_name'],
        lastName: data['last_name'],
        bio: data['bio'] ?? '',
        profilePicture: data['profile_picture'],
        profileStatus: data['profile_status'] ?? 'public',
      );
      _isLoggedIn = true;
      return _currentUser;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> checkLoggedIn() async {
    final token = await ApiClient.getToken();
    if (token == null) return false;
    final user = await getCurrentUser();
    return user != null;
  }
}
