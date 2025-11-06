import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/views/card/subviews/freeze_view.dart';
import 'package:ocean_card/presentation/views/card/subviews/details_view.dart';
import 'package:ocean_card/presentation/views/card/subviews/settings_view.dart';
import '../../../data/models/card_model.dart';
import 'widgets/card_carousel.dart';
import 'widgets/available_balance_card.dart';
import 'widgets/card_info.dart';
import 'widgets/card_action_buttons.dart';
import 'widgets/transaction_history_list.dart';
import 'widgets/carousel_indicator.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  int _currentIndex = 0;

  final List<CardModel> _cards = [
    CardModel(
      svgAsset: 'assets/card_black.svg',
      available: 1250.75,
      name: 'Alex Johnson',
      lastDigits: '****8456',
      history: [
        Movement('Sent to John', '-\$120.00', 'Yesterday'),
        Movement('Deposit', '+\$500.00', '2 days ago'),
        Movement('Amazon', '-\$80.00', '3 days ago'),
        Movement('Coffee Shop', '-\$4.50', 'Today'),
        Movement('ATM Withdrawal', '-\$100.00', 'Yesterday'),
        Movement('Salary', '+\$1500.00', '2 days ago'),
        Movement('Netflix', '-\$12.99', '2 days ago'),
        Movement('Uber', '-\$8.20', '3 days ago'),
        Movement('Grocery Store', '-\$54.10', '3 days ago'),
        Movement('Transfer Received', '+\$200.00', '4 days ago'),
        Movement('Bookstore', '-\$23.00', '5 days ago'),
        Movement('Pharmacy', '-\$15.75', '6 days ago'),
        Movement('Gym Membership', '-\$45.00', '1 week ago'),
      ],
    ),
  ];

  void _openFreeze() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FreezeView()));
  }

  void _openDetails() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const DetailsView()));
  }

  void _openSettings() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SettingsView()));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final card = _cards[_currentIndex];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'My current cards',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Available balance
                    AvailableBalanceCard(available: card.available),
                    const SizedBox(height: 24),

                    // Card carousel
                    SizedBox(
                      height: 200,
                      child: CardCarousel(
                        cards: _cards,
                        currentIndex: _currentIndex,
                        onChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Carousel indicator
                    CarouselIndicator(
                      currentIndex: _currentIndex,
                      itemCount: _cards.length,
                    ),
                    const SizedBox(height: 32),

                    // Card info
                    CardInfo(card: card),
                    const SizedBox(height: 24),

                    // Action buttons
                    CardActionButtons(
                      onFreeze: _openFreeze,
                      onDetails: _openDetails,
                      onSettings: _openSettings,
                    ),
                    const SizedBox(height: 32),

                    // Transaction history
                    TransactionHistoryList(history: card.history),
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
