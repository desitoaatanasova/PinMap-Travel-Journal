import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class AuthService {
  static UserProfile? _currentUser;
  static bool _isLoggedIn = false;

  static bool get isLoggedIn => _isLoggedIn;
  static UserProfile? get currentUser => _currentUser;

  static int? _userIdFrom(dynamic raw) {
    if (raw == null) return null;
    if (raw is int) return raw;
    return int.tryParse(raw.toString());
  }

  static Future<bool> login(String username, String password) async {
    try {
      final data = await ApiClient.post('/auth/login', body: {
        'username': username,
        'password': password,
      }, auth: false);
      await ApiClient.setToken(data['token']);
      final u = data['user'];
      final userId = _userIdFrom(u['userId']) ?? _userIdFrom(u['user_id']) ?? 0;
      await SyncQueueService.activateUser(userId);
      _currentUser = UserProfile(
        userId: userId,
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
      final userId = _userIdFrom(u['userId']) ?? _userIdFrom(u['user_id']) ?? 0;
      await SyncQueueService.activateUser(userId);
      _currentUser = UserProfile(
        userId: userId,
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
    await SyncQueueService.deactivateUser();
    _currentUser = null;
    _isLoggedIn = false;
  }

  static Future<UserProfile?> getCurrentUser() async {
    try {
      final data = await ApiClient.get('/auth/me');
      final userId = _userIdFrom(data['user_id']) ?? _userIdFrom(data['userId']) ?? 0;
      await SyncQueueService.activateUser(userId);
      _currentUser = UserProfile(
        userId: userId,
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
