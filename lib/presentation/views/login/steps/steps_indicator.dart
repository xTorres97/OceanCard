import 'package:flutter/material.dart';

class StepsIndicator extends StatelessWidget {
  final int currentIndex;
  final Color primaryColor;
  final Color onSurface;

  const StepsIndicator({
    super.key,
    required this.currentIndex,
    required this.primaryColor,
    required this.onSurface,
  });

  Widget _tick(Color color) {
    return Container(width: 28, height: 2, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _tick(
          currentIndex == 0 ? primaryColor : onSurface.withValues(alpha: 0.3),
        ),
        const SizedBox(width: 8),
        _tick(
          currentIndex == 1 ? primaryColor : onSurface.withValues(alpha: 0.3),
        ),
        const SizedBox(width: 8),
        _tick(
          currentIndex == 2 ? primaryColor : onSurface.withValues(alpha: 0.3),
        ),
        const SizedBox(width: 8),
        _tick(
          currentIndex == 3 ? primaryColor : onSurface.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
