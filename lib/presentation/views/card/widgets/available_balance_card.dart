import 'package:flutter/material.dart';

class AvailableBalanceCard extends StatelessWidget {
  final double available;

  const AvailableBalanceCard({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w100,
              color: Colors.white.withAlpha(179),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${available.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
