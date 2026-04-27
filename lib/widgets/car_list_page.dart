import 'package:flutter/material.dart';

import '../features/car/car.dart';
import '../features/car/car_service.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final CarService _carService = CarService();

  int selectedIndex = 0;
  double sheetSize = 0.55;
  bool _isLoading = false;
  String? _errorMessage;
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars({bool showLoading = true}) async {
    if (showLoading) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final data = await _carService.listCars(perPage: 10);
      if (!mounted) return;

      setState(() {
        cars = data;
        selectedIndex =
            cars.isEmpty ? 0 : selectedIndex.clamp(0, cars.length - 1).toInt();
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadCars(showLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          setState(() {
            sheetSize = notification.extent;
          });
          return true;
        },
        child: Stack(
          children: [
            /// ================= MAP (CO GIAN) =================
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: screenHeight * (1 - sheetSize),
              width: double.infinity,
              child: Stack(
                children: [
                  Container(color: Colors.grey[300]),
                  const Center(
                    child: Text(
                      'Map here',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  /// BACK BUTTON
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// SEARCH BOX
                  Positioned(
                    top: 80,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Ban muon di dau?'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ================= SHEET =================
            DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        children: [
                          /// DRAG HANDLE
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          /// TITLE
                          const Text(
                            'Chon loai xe',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),
                          _buildCarContent(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarContent() {
    if (_isLoading && cars.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null && cars.isEmpty) {
      return _CarMessage(
        icon: Icons.error_outline,
        title: 'Không tải được danh sách xe',
        message: _errorMessage!,
        actionLabel: 'Thử lại',
        onAction: () => _loadCars(),
      );
    }

    if (cars.isEmpty) {
      return const _CarMessage(
        icon: Icons.directions_car_filled,
        title: 'Chưa có xe',
        message: 'Danh sách đang trống.',
      );
    }

    return Column(
      children: [
        ...List.generate(cars.length, (index) {
          final item = cars[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: CarItem(
              car: item,
              selected: selectedIndex == index,
            ),
          );
        }),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: cars.isEmpty
                ? null
                : () {
                    final selected = cars[selectedIndex];
                    debugPrint('Chọn car: ${selected.name}');
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B14F),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CarItem extends StatelessWidget {
  final Car car;
  final bool selected;

  const CarItem({
    super.key,
    required this.car,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? const Color(0xFF00B14F) : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: selected ? const Color(0xFFE8F5E9) : Colors.white,
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_car_filled,
              size: 32, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name.isEmpty ? 'Unnamed car' : car.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (car.carType.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    car.carType,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
                if (car.content.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    car.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            car.formattedPrice,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CarMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _CarMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey, size: 36),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
