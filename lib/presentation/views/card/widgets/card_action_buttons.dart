import 'package:flutter/material.dart';

class CardActionButtons extends StatelessWidget {
  final VoidCallback onFreeze;
  final VoidCallback onDetails;
  final VoidCallback onSettings;

  const CardActionButtons({
    super.key,
    required this.onFreeze,
    required this.onDetails,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Freeze
        ElevatedButton.icon(
          onPressed: onFreeze,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            elevation: 2,
          ),
          icon: Icon(Icons.lock, size: 20, color: colorScheme.onPrimary),
          label: Text(
            'Freeze',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        // Details
        TextButton.icon(
          onPressed: onDetails,
          icon: Icon(Icons.info_outline, color: colorScheme.primary),
          label: Text(
            'Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.primary,
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
        ),
        // Settings
        TextButton.icon(
          onPressed: onSettings,
          icon: Icon(Icons.settings, color: colorScheme.primary),
          label: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.primary,
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
        ),
      ],
    );
  }
}
