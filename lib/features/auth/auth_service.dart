import '../../core/api/api_service.dart';
import '../../core/storage/token_storage.dart';
import 'models/user.dart';

class AuthService {
  final ApiService _api = ApiService();
  final TokenStorage _storage = TokenStorage();

  Future<User> login(String email, String password) async {
    final response = await _api.post('/admin/login', {
      'email': email,
      'password': password,
    });

    if (response['status'] == true) {
      final data = response['data'];

      final token = data['token'];
      final userData = data['user'];

      await _storage.saveToken(token);

      return User.fromJson(userData, token); // ✅ FIX CHUẨN
    } else {
      throw Exception(response['message'] ?? 'Login failed');
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _api.get('/admin/me');

    if (response['status'] == true) {
      return response['data'];
    } else {
      throw Exception('Unauthorized');
    }
  }

  Future<void> logout() async {
    await _storage.clearToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();
    return token != null;
  }
}
