import '../../core/api/api_service.dart';
import 'car.dart';

class CarService {
  final ApiService _api = ApiService();

  Future<List<Car>> listCars({
    String? carType,
    String? keyword,
    int perPage = 10,
  }) async {
    final query = <String, String>{
      'per_page': perPage.toString(),
      if (carType != null && carType.isNotEmpty) 'car_type': carType,
      if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
    };

    final endpoint =
        Uri(path: '/admin/car/list', queryParameters: query).toString();
    final response = await _api.get(endpoint);

    if (response['status'] != true) {
      throw Exception(response['message'] ?? 'Can not load car list');
    }

    final payload = response['data'];
    final list = payload is Map ? payload['data'] : payload;

    if (list is! List) {
      return [];
    }

    return list
        .whereType<Map>()
        .map((item) => Car.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
