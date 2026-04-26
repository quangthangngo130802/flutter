import '../../core/api/api_service.dart';

class UserService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getMe() async {
    final response = await _api.get('/admin/me');
    
    if (response['status'] == true) {
      return response['data'];
    } else {
      throw Exception('Unauthorized');
    }
  }
}
