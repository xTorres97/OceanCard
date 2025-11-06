import 'package:flutter/material.dart';

class TradesView extends StatelessWidget {
  const TradesView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trades', style: TextStyle(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: Center(
        child: Text(
          'Trades details coming soon!',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
