import 'package:flutter/material.dart';

/// A small shared dialog widget to keep dialogs visually consistent.
/// Use the helper `showAppDialog` to present it.
class AppDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget>? actions;

  const AppDialog({super.key, required this.title, this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(title),
      content: content,
      actions:
          actions ??
          [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Aceptar'),
            ),
          ],
    );
  }
}

/// Convenience helper to show the dialog.
Future<T?> showAppDialog<T>(
  BuildContext context, {
  required String title,
  Widget? content,
  List<Widget>? actions,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) =>
        AppDialog(title: title, content: content, actions: actions),
  );
}
