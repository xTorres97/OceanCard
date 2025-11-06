import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullBalanceCard extends StatelessWidget {
  final Map<String, dynamic> currency;
  final bool isSelected;
  final bool showBalance;
  final double balanceUSD;
  final ColorScheme colorScheme;

  const FullBalanceCard({
    super.key,
    required this.currency,
    required this.isSelected,
    required this.showBalance,
    required this.balanceUSD,
    required this.colorScheme,
  });

  double get _currentBalance {
    return balanceUSD * currency['rate'];
  }

  String get _formattedBalance {
    if (currency['code'] == 'BTC') {
      return '${currency['symbol']}${_currentBalance.toStringAsFixed(6)}';
    }
    return '${currency['symbol']}${_currentBalance.toStringAsFixed(2)}';
  }

  String get _balanceSubtitle {
    if (currency['code'] == 'USD') {
      return 'Balance in USD';
    } else if (currency['code'] == 'USDT') {
      return 'Balance in USDT';
    } else {
      return 'Balance invested in ${currency['code']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con nombre de la moneda
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currency['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colorScheme.outline, width: 1),
                  ),
                  child: Text(
                    currency['code'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),

            // Balance y avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Balance info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        showBalance ? _formattedBalance : '••••••',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (showBalance && currency['code'] != 'USD')
                        Text(
                          '\$${balanceUSD.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      Text(
                        _balanceSubtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),

                // Currency avatar
                SizedBox(
                  width: 50,
                  height: 50,

                  child: Center(
                    child: SvgPicture.asset(
                      currency['svgAsset'],
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        colorScheme.onSurfaceVariant,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
