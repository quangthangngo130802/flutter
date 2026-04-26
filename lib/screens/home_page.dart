import 'package:flutter/material.dart';

import '../widgets/app_refresh.dart';
import '../widgets/booking_section.dart';
import '../widgets/greeting_section.dart';
import '../widgets/hot_promotions.dart';
import '../widgets/promo_banner.dart';
import '../widgets/service_categories.dart';
import '../widgets/top_banner.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? user;
  final RefreshCallback? onRefresh;

  const HomePage({
    super.key,
    this.user,
    this.onRefresh,
  });

  Future<void> _handleRefresh() async {
    if (onRefresh != null) {
      await onRefresh!();
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return AppRefresh(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
