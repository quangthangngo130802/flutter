import 'package:flutter/material.dart';

class AppRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const AppRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child, // ✅ dùng trực tiếp
    );
  }
}
