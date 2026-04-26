import 'package:flutter/material.dart';
import 'bike_list_page.dart';
class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600), // fix PC
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 4;

                // responsive
                if (constraints.maxWidth > 500) {
                  crossAxisCount = 5;
                }

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7, // 👈 FIX lệch mobile
                  children: [
                    _buildServiceItem(
                      icon: Icons.directions_car_filled,
                      label: 'Car',
                      color: const Color(0xFF00B14F),
                      bgColor: const Color(0xFFE8F5E9),
                    ),
                    _buildServiceItem(
                      icon: Icons.two_wheeler,
                      label: 'Bike',
                      color: const Color(0xFF00B14F),
                      bgColor: const Color(0xFFE8F5E9),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BikeListPage()),
                        );
                      },
                    ),
                    _buildServiceItem(
                      icon: Icons.delivery_dining,
                      label: 'Express',
                      color: const Color(0xFF00B14F),
                      bgColor: const Color(0xFFE8F5E9),
                    ),
                    _buildServiceItem(
                      icon: Icons.car_rental,
                      label: 'Rental car',
                      color: const Color(0xFF00B14F),
                      bgColor: const Color(0xFFE8F5E9),
                    ),
                    _buildServiceItem(
                      icon: Icons.card_membership,
                      label: 'Subscription',
                      color: const Color(0xFFF57C00),
                      bgColor: const Color(0xFFFFF3E0),
                      badge: 'HOT',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
    String? badge,
    VoidCallback? onTap, // 👈 thêm
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),

            if (badge != null)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5252),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
