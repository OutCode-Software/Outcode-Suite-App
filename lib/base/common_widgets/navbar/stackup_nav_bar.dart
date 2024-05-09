import 'package:flutter/material.dart';

class StackUpNavBar extends StatelessWidget implements PreferredSizeWidget {
  const StackUpNavBar({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50), child: child);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
