import 'package:flutter/material.dart';

class TopBanner extends StatefulWidget {
  const TopBanner({super.key});

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoScrollBanner);
  }

  void _autoScrollBanner() {
    if (!mounted) return;
    final nextPage = (_currentBannerPage + 1) % 3;
    _bannerController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 4), _autoScrollBanner);
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() => _currentBannerPage = index);
            },
            children: [
              _buildBannerSlide(
                gradient: const [Color(0xFF4FC3F7), Color(0xFF81D4FA)],
                title: 'HÈ TỚI\nXANH',
                subtitle: 'GIÁ MỚI',
                detail: 'TỐT HƠN 15% GIÁ CŨ',
                accentColor: const Color(0xFFFFA726),
              ),
              _buildBannerSlide(
                gradient: const [Color(0xFF66BB6A), Color(0xFFA5D6A7)],
                title: 'XANH SM\nBIKE',
                subtitle: 'GIẢM 30%',
                detail: 'CHO CHUYẾN ĐI ĐẦU TIÊN',
                accentColor: const Color(0xFFFFEB3B),
              ),
              _buildBannerSlide(
                gradient: const [Color(0xFF26C6DA), Color(0xFF80DEEA)],
                title: 'ĐẶT XE\nNHANH',
                subtitle: 'AN TOÀN',
                detail: 'XANH - SẠCH - ĐẸP',
                accentColor: const Color(0xFFE1F5FE),
              ),
            ],
          ),
          // Page indicators
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentBannerPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentBannerPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlide({
    required List<Color> gradient,
    required String title,
    required String subtitle,
    required String detail,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 10,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 40,
              child: Icon(
                Icons.electric_car,
                size: 80,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Positioned(
              left: 20,
              top: 10,
              child: Icon(
                Icons.cloud,
                size: 30,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            Positioned(
              right: 60,
              top: 5,
              child: Icon(
                Icons.cloud,
                size: 20,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Positioned(
              left: -10,
              bottom: 20,
              child: Icon(
                Icons.park,
                size: 50,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Positioned(
              right: 100,
              bottom: 10,
              child: Icon(
                Icons.nature,
                size: 40,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B5E20),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
