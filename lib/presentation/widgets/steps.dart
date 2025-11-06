import 'package:flutter/material.dart';

class StepsIndicator extends StatelessWidget {
  final int totalSteps;
  final int stepNow;

  const StepsIndicator({
    super.key,
    required this.totalSteps,
    required this.stepNow,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = stepNow >= 0 && index <= stepNow;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: 18,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive
                ? colorScheme.primary
                : colorScheme.primary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
