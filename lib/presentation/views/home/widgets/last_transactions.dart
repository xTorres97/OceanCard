import 'package:flutter/material.dart';
import 'package:ocean_card/core/configuration/tema/theme.dart';
import 'package:ocean_card/presentation/views/history/history_view.dart';
import 'package:ocean_card/presentation/views/home/widgets/recent_activity_list.dart';

class LastTransactions extends StatelessWidget {
  const LastTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Últimas transacciones',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HistoryView()),
                  );
                },
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: colorScheme.onBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Show a compact list of recent activities
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const RecentActivityList(),
        ),
      ],
    );
  }
}
