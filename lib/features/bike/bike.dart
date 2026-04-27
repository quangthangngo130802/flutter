class Bike {
  final int? id;
  final String name;
  final String bikeType;
  final String content;
  final dynamic price;

  const Bike({
    required this.id,
    required this.name,
    required this.bikeType,
    required this.content,
    required this.price,
  });

  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      bikeType: (json['bike_type'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      price: json['price'],
    );
  }

  String get formattedPrice {
    final rawPrice = price?.toString().trim() ?? '';
    if (rawPrice.isEmpty) return 'Lien he';

    final value = num.tryParse(rawPrice.replaceAll(',', ''));
    if (value == null) return rawPrice;

    final digits = value.round().toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      final indexFromRight = digits.length - i;
      buffer.write(digits[i]);

      if (indexFromRight > 1 && indexFromRight % 3 == 1) {
        buffer.write(',');
      }
    }

    return '$buffer đ';
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
