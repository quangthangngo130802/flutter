import 'package:flutter/material.dart';
import '../widgets/top_banner.dart';
import '../widgets/greeting_section.dart';
import '../widgets/booking_section.dart';
import '../widgets/service_categories.dart';
import '../widgets/promo_banner.dart';
import '../widgets/hot_promotions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Banner Slider
          const TopBanner(),
          // Greeting + Points
          const GreetingSection(),
          // Search / Booking Section
          const BookingSection(),
          // Service Categories
          const ServiceCategories(),
          const SizedBox(height: 8),
          // Divider
          Container(height: 8, color: const Color(0xFFF0F0F0)),
          // Promotional Banner
          const PromoBanner(),
          // Divider
          Container(height: 8, color: const Color(0xFFF0F0F0)),
          // Hot Promotions
          const HotPromotions(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
