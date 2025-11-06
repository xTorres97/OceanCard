import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/views/actions/actions.dart';
import 'package:ocean_card/presentation/views/home/widgets/quick_actions_container.dart';

class BalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggleVisibility;
  final String formattedBalance;
  final String balanceSubtitle;
  final double balanceUSD;
  final String selectedCurrency;
  final List<Map<String, dynamic>> currencies;
  final Function(String) onCurrencyChanged;
  final ColorScheme colorScheme;

  const BalanceCard({
    super.key,
    required this.showBalance,
    required this.onToggleVisibility,
    required this.formattedBalance,
    required this.balanceSubtitle,
    required this.balanceUSD,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Single balance display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Archivos totales',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              IconButton(
                icon: Icon(
                  showBalance ? Icons.visibility : Icons.visibility_off,
                  color: colorScheme.onSurface,
                ),
                onPressed: onToggleVisibility,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showBalance ? formattedBalance : '••••••',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      balanceSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              // Currency dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outline, width: 1),
                ),
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onCurrencyChanged(newValue);
                    }
                  },
                  items: currencies.map<DropdownMenuItem<String>>((currency) {
                    return DropdownMenuItem<String>(
                      value: currency['code'],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currency['code'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  underline: const SizedBox(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.onSurface,
                  ),
                  style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          QuickActionsContainer(
            colorScheme: colorScheme,
            onDepositTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const DepositView())),
            onExchangeTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ExchangeView())),
            onWithdrawTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const WithdrawView())),
            onCvuTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const CvuView())),
          ),
        ],
      ),
    );
  }
}
