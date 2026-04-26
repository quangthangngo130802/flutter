import 'package:flutter/material.dart';
import '../../features/auth/auth_service.dart';
import '../../features/auth/login_page.dart';
import 'package:my_app/main.dart';

class AccountPage extends StatelessWidget {
  final VoidCallback? onBack;
  final Map<String, dynamic>? user;

  const AccountPage({
    super.key,
    this.onBack,
    this.user,
  });

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';

    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) return date;

    return "${parsedDate.day.toString().padLeft(2, '0')}/"
        "${parsedDate.month.toString().padLeft(2, '0')}/"
        "${parsedDate.year}";
  }

  String formatGender(dynamic gender) {
    if (gender == null) return '';
    if (gender == 1 || gender == 'male') return 'Nam';
    if (gender == 0 || gender == 'female') return 'Nữ';
    return gender.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          /// ================= CONTENT =================
          SingleChildScrollView(
            child: Column(
              children: [
                /// HEADER + AVATAR
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF00B14F), Color(0xFF00D68F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/300'),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                Text(
                  user!['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                /// INFO CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide.none,
                    ),
                    elevation: 4,
                    child: Column(
                      children: [
                        _InfoTile(
                          icon: Icons.cake_outlined,
                          title: 'Ngày sinh',
                          value: formatDate(user?['birthday']),
                          isFirst: true,
                        ),
                        Divider(height: 1),
                        _InfoTile(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: user?['email'] ?? '',
                        ),
                        Divider(height: 1),
                        _InfoTile(
                          icon: Icons.email_outlined,
                          title: 'Điện thoại',
                          value: user?['phone'] ?? '',
                        ),
                        Divider(height: 1),
                        _InfoTile(
                          icon: Icons.person_outline,
                          title: 'Giới tính',
                          value: formatGender(user?['gender']),
                        ),
                        Divider(height: 1),
                        _InfoTile(
                          icon: Icons.location_on_outlined,
                          title: 'Địa chỉ',
                          value: user?['address'] ?? '',
                          isLast: true,
                        ),
                        Divider(height: 1),

                        /// LOGOUT
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          title: const Text(
                            'Đăng xuất',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Đăng xuất'),
                                content: const Text(
                                    'Bạn có chắc muốn đăng xuất không?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Hủy'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text(
                                      'Đăng xuất',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              final auth = AuthService();

                              await auth.logout(); // xóa token

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RootPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),

          /// ================= BACK BUTTON  =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6)
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (onBack != null) {
                        onBack!(); // 👈 quay về tab Home
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= ITEM =================
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isFirst;
  final bool isLast;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(10) : Radius.zero,
          bottom: isLast ? const Radius.circular(10) : Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF00B14F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF00B14F), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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
