import 'package:flutter/material.dart';
import '../widgets/top_banner.dart';
import '../widgets/greeting_section.dart';
import '../widgets/booking_section.dart';
import '../widgets/service_categories.dart';
import '../widgets/promo_banner.dart';
import '../widgets/hot_promotions.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? user; // 👈 thêm

  const HomePage({super.key, this.user}); // 👈 thêm

  /// 🔥 FUNCTION REFRESH
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("Reload data...");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // 👈 QUAN TRỌNG
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBanner(),
            GreetingSection(user: user),
            const BookingSection(),
            const ServiceCategories(),
            const SizedBox(height: 8),
            Container(height: 8, color: const Color(0xFFF0F0F0)),
            const PromoBanner(),
            Container(height: 8, color: const Color(0xFFF0F0F0)),
            const HotPromotions(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
