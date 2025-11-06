import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/views/actions/actions.dart';

class StatisticsCards extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback? onEarnMoney;
  final VoidCallback? onReports;
  final VoidCallback? onHistory;

  const StatisticsCards({
    super.key,
    required this.colorScheme,
    this.onEarnMoney,
    this.onReports,
    this.onHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Primera fila
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.compare_arrows,
                      label: 'Movements',
                      value: '12',
                      color: colorScheme.primary,
                      onTap: () => movementsAction(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.candlestick_chart,
                      label: 'Trades',
                      value: '1',
                      color: colorScheme.primary,
                      onTap: () => tradesAction(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.currency_bitcoin,
                      label: 'DeFi',
                      value: '3',
                      color: colorScheme.primary,
                      onTap: () => defiAction(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Segunda fila
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.monetization_on,
                      label: 'Earn Money',
                      value: '\$50',
                      color: colorScheme.primary,
                      onTap: () => earnMoneyAction(context),
                    ),
                  ),
                  Expanded(
                    child: StatCard(
                      icon: Icons.people,
                      label: 'Buy & Sell',
                      value: '8',
                      color: colorScheme.primary,
                      onTap: () => buySellAction(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.assessment,
                      label: 'Reports',
                      value: '5',
                      color: colorScheme.primary,
                      onTap: () => reportsAction(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.history,
                      label: 'History',
                      value: '24',
                      color: colorScheme.primary,
                      onTap: () => historyAction(context),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
