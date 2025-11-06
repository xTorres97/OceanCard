import 'package:flutter/material.dart';
import 'package:ocean_card/core/configuration/tema/theme.dart';
import 'package:ocean_card/presentation/views/actions/actions.dart';
import 'package:ocean_card/presentation/views/home/widgets/last_transactions.dart';
import 'package:ocean_card/presentation/views/home/widgets/carousel_rounded_buttons.dart';
import 'widgets/balance_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showBalance = true;
  String _selectedCurrency = 'USD';

  final List<Map<String, dynamic>> _currencies = [
    {
      'code': 'USD',
      'name': 'US Dollar',
      'symbol': '\$',
      'rate': 1.0,
      'svgAsset': 'assets/usd.svg',
    },
    {
      'code': 'USDT',
      'name': 'Tether',
      'symbol': '₮',
      'rate': 1.0,
      'svgAsset': 'assets/usdt.svg',
    },
    {
      'code': 'BTC',
      'name': 'Bitcoin',
      'symbol': '₿',
      'rate': 0.000024,
      'svgAsset': 'assets/btc.svg',
    },
  ];

  final double _balanceUSD = 1250.75;

  double get _currentBalance {
    final currency = _currencies.firstWhere(
      (c) => c['code'] == _selectedCurrency,
    );
    return _balanceUSD * currency['rate'];
  }

  String get _formattedBalance {
    final currency = _currencies.firstWhere(
      (c) => c['code'] == _selectedCurrency,
    );
    if (_selectedCurrency == 'BTC') {
      return '${currency['symbol']}${_currentBalance.toStringAsFixed(6)}';
    }
    return '${currency['symbol']}${_currentBalance.toStringAsFixed(2)}';
  }

  String get _balanceSubtitle {
    if (_selectedCurrency == 'USD') {
      return 'Balance in USD';
    } else if (_selectedCurrency == 'USDT') {
      return 'Balance in USDT';
    } else {
      return 'Balance invested in $_selectedCurrency';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance card with currency selection
                    BalanceCard(
                      showBalance: _showBalance,
                      onToggleVisibility: () {
                        setState(() {
                          _showBalance = !_showBalance;
                        });
                      },
                      formattedBalance: _formattedBalance,
                      balanceSubtitle: _balanceSubtitle,
                      balanceUSD: _balanceUSD,
                      selectedCurrency: _selectedCurrency,
                      currencies: _currencies,
                      onCurrencyChanged: (currency) {
                        setState(() {
                          _selectedCurrency = currency;
                        });
                      },
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CarouselRoundedButtons(
                            items: [
                              CarouselRoundedButtonItem(
                                icon: Icons.credit_card,
                                backgroundColor: colorScheme.onBlack,
                                iconColor: colorScheme.surface,
                                label: 'Tarjetas',
                                onTap: () {},
                              ),

                              CarouselRoundedButtonItem(
                                icon: Icons.send,
                                backgroundColor: colorScheme.onBlack,
                                iconColor: colorScheme.surface,
                                label: 'Enviar dinero',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const AddFundsView(),
                                    ),
                                  );
                                },
                              ),
                              CarouselRoundedButtonItem(
                                icon: Icons.account_balance_wallet,
                                backgroundColor: colorScheme.onBlack,
                                iconColor: colorScheme.surface,
                                label: 'Deposito',
                                onTap: () {},
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          LastTransactions(),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
