import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyCard extends StatelessWidget {
  final Map<String, dynamic> currency;
  final bool isSelected;

  const CurrencyCard({
    super.key,
    required this.currency,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(currency['svgAsset'], width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            currency['code'],
            style: TextStyle(
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
