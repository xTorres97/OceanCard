import 'package:flutter/material.dart';
import '../../../../data/models/card_model.dart';

class TransactionHistoryList extends StatelessWidget {
  final List<Movement> history;

  const TransactionHistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, _) => const Divider(height: 1, thickness: 0.5),
          itemBuilder: (context, idx) {
            final m = history[idx];
            final isNegative = m.amount.startsWith('-');
            final isPositive = m.amount.startsWith('+');
            IconData icon;
            Color iconColor;
            if (isNegative) {
              icon = Icons.arrow_upward;
              iconColor = colorScheme.error;
            } else if (isPositive) {
              icon = Icons.arrow_downward;
              iconColor = colorScheme.secondary;
            } else {
              icon = Icons.swap_horiz;
              iconColor = colorScheme.primary;
            }
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: iconColor.withValues(alpha: 0.15),
                child: Icon(icon, color: iconColor),
              ),
              title: Text(
                m.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(m.date),
              trailing: Text(
                m.amount,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
