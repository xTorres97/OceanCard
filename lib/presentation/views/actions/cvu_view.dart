import 'package:flutter/material.dart';

class CvuView extends StatelessWidget {
  const CvuView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('CVU', style: TextStyle(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.credit_card, size: 80, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'Your CVU',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your unique banking code for transfers and deposits.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withAlpha(180),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SelectableText(
                '0000-1234-5678-9012',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
