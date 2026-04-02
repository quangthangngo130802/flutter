import 'package:flutter/material.dart';

class HotPromotions extends StatelessWidget {
  const HotPromotions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hot promotions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPromoCard(
                  gradient: const [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                  title: 'GIẢM 50%',
                  subtitle: 'Cho chuyến đi đầu tiên',
                  icon: Icons.local_offer,
                ),
                const SizedBox(width: 12),
                _buildPromoCard(
                  gradient: const [Color(0xFF66BB6A), Color(0xFF43A047)],
                  title: 'XANH SM BIKE',
                  subtitle: 'Giảm 30K mỗi chuyến',
                  icon: Icons.two_wheeler,
                ),
                const SizedBox(width: 12),
                _buildPromoCard(
                  gradient: const [Color(0xFFFF7043), Color(0xFFFF5722)],
                  title: 'FREE SHIP',
                  subtitle: 'Giao hàng Express',
                  icon: Icons.delivery_dining,
                ),
                const SizedBox(width: 12),
                _buildPromoCard(
                  gradient: const [Color(0xFFAB47BC), Color(0xFF8E24AA)],
                  title: 'XANH TOUR',
                  subtitle: 'Giảm 100K tour thành phố',
                  icon: Icons.tour,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required List<Color> gradient,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              icon,
              size: 80,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      const Text(
                        'Xanh SM',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
