class CardModel {
  final String svgAsset;
  final double available;
  final String name;
  final String lastDigits;
  final List<Movement> history;

  CardModel({
    required this.svgAsset,
    required this.available,
    required this.name,
    required this.lastDigits,
    required this.history,
  });
}

class Movement {
  final String title;
  final String amount;
  final String date;

  Movement(this.title, this.amount, this.date);
}
