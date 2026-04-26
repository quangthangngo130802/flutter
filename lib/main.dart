import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_screen.dart';
import 'features/auth/login_page.dart';
import 'features/auth/auth_service.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const XanhSMApp());
}

class XanhSMApp extends StatelessWidget {
  const XanhSMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xanh SM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B14F),
          primary: const Color(0xFF00B14F),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const RootPage(), // 👈 đổi chỗ này
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        // loading
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // đã login -> vào MainScreen
        if (snapshot.data!) {
          return const MainScreen();
        }

        // chưa login -> vào Login
        return const LoginPage();
      },
    );
  }
}
