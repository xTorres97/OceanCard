import 'package:flutter/material.dart';
import 'home_action_card.dart';

class ActionsGrid extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onTransferTap;
  final VoidCallback onBuySellTap;
  final VoidCallback onEarnMoneyTap;
  final VoidCallback onReportsTap;

  const ActionsGrid({
    super.key,
    required this.colorScheme,
    required this.onTransferTap,
    required this.onBuySellTap,
    required this.onEarnMoneyTap,
    required this.onReportsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determinar número de columnas basado en el ancho
          int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
          double aspectRatio = constraints.maxWidth > 600 ? 1.1 : 1.3;

          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: aspectRatio,
            children: [
              HomeActionCard(
                title: 'Transfer',
                icon: Icons.sync_alt,
                description: 'Transfer your funds',
                onTap: onTransferTap,
                colorScheme: colorScheme,
              ),
              HomeActionCard(
                title: 'Buy & Sell',
                icon: Icons.swap_horiz,
                description: 'Buy and sell assets',
                onTap: onBuySellTap,
                colorScheme: colorScheme,
              ),
              HomeActionCard(
                title: 'Earn Money',
                icon: Icons.monetization_on,
                description: 'Invite and earn rewards',
                onTap: onEarnMoneyTap,
                colorScheme: colorScheme,
              ),
              HomeActionCard(
                title: 'Reports',
                icon: Icons.analytics,
                description: 'View spending reports',
                onTap: onReportsTap,
                colorScheme: colorScheme,
              ),
            ],
          );
        },
      ),
    );
  }
}
