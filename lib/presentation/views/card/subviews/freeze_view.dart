import 'package:flutter/material.dart';

class FreezeView extends StatelessWidget {
  const FreezeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Freeze Card',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 80, color: colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              'Freeze your card',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Temporarily disable your card for security. You can unfreeze it anytime.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha(180),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Card frozen!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    backgroundColor: colorScheme.primary,
                  ),
                );
              },
              icon: const Icon(Icons.lock),
              label: Text(
                'Freeze Now',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
