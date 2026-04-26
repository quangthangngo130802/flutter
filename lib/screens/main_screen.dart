import 'package:flutter/material.dart';
import 'home_page.dart';
import '../features/account/account_page.dart';
import '../features/user/user_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Map<String, dynamic>? user; // ✅ giữ user toàn app
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  /// 👉 LOAD USER 1 LẦN
  Future<void> loadUser() async {
    final data = await UserService().getMe();
    setState(() {
      user = data;

      /// 👉 init pages sau khi có user
      _pages = [
        HomePage(user: user), // nếu cần
        _PlaceholderPage(title: 'Activity'),
        _PlaceholderPage(title: 'Notification'),
        AccountPage(
          user: user, // ✅ truyền user
          onBack: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 👉 chưa có user thì loading
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.receipt_long_rounded, 'Activity', 1),
              _buildNavItem(Icons.notifications_outlined, 'Notification', 2),
              _buildNavItem(Icons.person_outline_rounded, 'Account', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 6),
        width: 72,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00B14F).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF00B14F)
                  : const Color(0xFF9E9E9E),
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF00B14F)
                    : const Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 👇 Placeholder
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}