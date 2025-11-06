import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (i) {
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: i == currentIndex
                ? colorScheme.primary
                : colorScheme.primary.withAlpha(77),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
