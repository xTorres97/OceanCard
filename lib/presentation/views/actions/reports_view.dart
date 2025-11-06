import 'package:flutter/material.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports', style: TextStyle(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.analytics,
                        size: 60,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Spending Reports',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Track your spending patterns and financial insights',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Report types
                Text(
                  'Available Reports',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView(
                    children: [
                      _ReportCard(
                        icon: Icons.trending_down,
                        title: 'Monthly Spending',
                        subtitle: 'View your monthly expenses breakdown',
                        color: colorScheme.error, // Monthly Spending
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _ReportCard(
                        icon: Icons.trending_up,
                        title: 'Income Report',
                        subtitle: 'Track your income sources and trends',
                        color: colorScheme.secondary, // Income Report
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _ReportCard(
                        icon: Icons.category,
                        title: 'Category Analysis',
                        subtitle: 'See spending by categories',
                        color: colorScheme.primary, // Category Analysis
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _ReportCard(
                        icon: Icons.savings,
                        title: 'Savings Goals',
                        subtitle: 'Monitor your savings progress',
                        color: colorScheme.tertiary, // Savings Goals
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // Generate report button
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Generating detailed report...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.file_download),
                    label: const Text('Generate Full Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ReportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
