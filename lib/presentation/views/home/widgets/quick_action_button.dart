import 'package:flutter/material.dart';
import 'package:ocean_card/core/configuration/tema/theme.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final String? tooltip;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.backgroundColor = Colors.black,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final button = ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: colorScheme.onBlack,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        // Make the button expand to the parent's width without using Expanded
        minimumSize: Size(double.infinity, 48),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
