export 'deposit_view.dart';
export 'exchange_view.dart';
export 'withdraw_view.dart';
export 'cvu_view.dart';
export 'add_funds_view.dart';
export 'transfer_view.dart';
export 'buy_sell_view.dart';
export 'earn_money_view.dart';

import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/views/actions/earn_money_view.dart';
import 'package:ocean_card/presentation/views/actions/reports_view.dart';
import 'package:ocean_card/presentation/views/actions/movements_view.dart';
import 'package:ocean_card/presentation/views/actions/trades_view.dart';
import 'package:ocean_card/presentation/views/actions/defi_view.dart';
import 'package:ocean_card/presentation/views/history/history_view.dart';
import 'package:ocean_card/presentation/views/actions/buy_sell_view.dart';

void movementsAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const MovementsView()));
}

void tradesAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const TradesView()));
}

void defiAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const DefiView()));
}

void earnMoneyAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const EarnMoneyView()));
}

void buySellAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const BuySellView()));
}

void reportsAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const ReportsView()));
}

void historyAction(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const HistoryView()));
}
