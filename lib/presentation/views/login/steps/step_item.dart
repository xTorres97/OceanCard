import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const StepItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          // Use displayMedium as heading and enforce heavy weight
          style:
              textTheme.displayMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
              ) ??
              TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style:
              textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w400,
              ) ??
              TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
