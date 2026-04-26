import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  final TokenStorage _storage = TokenStorage();

  /// 🔥 HEADER CHUNG
  Future<Map<String, String>> _headers({bool isJson = true}) async {
    final token = await _storage.getToken();

    return {
      'Accept': 'application/json',
      if (isJson) 'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token', 
    };
  }

  /// POST
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// GET
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(),
    );

    return _handleResponse(response); 
  }

  /// 🔥 Xử lý response chuẩn
  Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'API Error');
    }
  }
}
