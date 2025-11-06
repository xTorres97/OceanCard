import 'package:flutter/material.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activities = [
      {
        'icon': Icons.arrow_upward,
        'title': 'Sent to John',
        'subtitle': 'Yesterday',
        'amount': '-\$120.00',
        'color': colorScheme.error,
      },
      {
        'icon': Icons.arrow_downward,
        'title': 'Deposit',
        'subtitle': '2 days ago',
        'amount': '+\$500.00',
        'color': colorScheme.secondary,
      },
      {
        'icon': Icons.shopping_cart,
        'title': 'Amazon',
        'subtitle': '3 days ago',
        'amount': '-\$80.00',
        'color': colorScheme.error,
      },
    ];

    return Column(
      children: activities.map((a) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: (a['color'] as Color).withValues(alpha: 0.15),
            child: Icon(a['icon'] as IconData, color: a['color'] as Color),
          ),
          title: Text(
            a['title'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(a['subtitle'] as String),
          trailing: Text(
            a['amount'] as String,
            style: TextStyle(
              color: a['color'] as Color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }
}
