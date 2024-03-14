import 'package:flutter/material.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;

  const CardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
