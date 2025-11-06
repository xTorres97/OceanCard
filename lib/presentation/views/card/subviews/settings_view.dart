import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Settings',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          ListTile(
            leading: Icon(Icons.lock, color: colorScheme.primary),
            title: Text(
              'Change PIN',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.visibility_off, color: colorScheme.primary),
            title: Text(
              'Hide Card Number',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.delete, color: colorScheme.error),
            title: Text(
              'Delete Card',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: colorScheme.error),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Text(
            'Manage your card settings here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha(180),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
