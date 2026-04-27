import '../../core/api/api_service.dart';
import 'bike.dart';

class BikeService {
  final ApiService _api = ApiService();

  Future<List<Bike>> listBikes({
    String? bikeType,
    String? keyword,
    int perPage = 10,
  }) async {
    final query = <String, String>{
      'per_page': perPage.toString(),
      if (bikeType != null && bikeType.isNotEmpty) 'bike_type': bikeType,
      if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
    };

    final endpoint = Uri(path: '/admin/bike/list', queryParameters: query).toString();
    final response = await _api.get(endpoint);

    if (response['status'] != true) {
      throw Exception(response['message'] ?? 'Can not load bike list');
    }

    final payload = response['data'];
    final list = payload is Map ? payload['data'] : payload;

    if (list is! List) {
      return [];
    }

    return list
        .whereType<Map>()
        .map((item) => Bike.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
