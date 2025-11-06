import 'package:flutter/material.dart';

class CarouselRoundedButtons extends StatelessWidget {
  final List<CarouselRoundedButtonItem> items;
  final double iconSize;
  final double circleSize;
  final double spacing;

  const CarouselRoundedButtons({
    super.key,
    required this.items,
    this.iconSize = 24,
    this.circleSize = 56,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    // Estimate label height: fontSize 12 with height 1.4 and 2 max lines
    const double labelFontSize = 12.0;
    const double labelLineHeight = 1.4;
    const int labelMaxLines = 2;
    final double labelHeight = labelFontSize * labelLineHeight * labelMaxLines;
    const double safetyPadding =
        6.0; // small extra space to avoid sub-pixel overflows
    final double totalHeight = circleSize + 8 + labelHeight + safetyPadding;

    return SizedBox(
      width: double.infinity,
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double horizontalPadding = 12.0;
          final double availableWidth =
              (constraints.maxWidth.isFinite ? constraints.maxWidth : 0) -
              horizontalPadding * 2;
          final int count = items.length;
          final double minItemWidth = circleSize + 8; // same as before
          final double totalSpacing = spacing * (count > 0 ? count - 1 : 0);
          double itemWidth = minItemWidth;

          if (count > 0 && availableWidth > 0) {
            if (minItemWidth * count + totalSpacing <= availableWidth) {
              // we can expand items to fill available width evenly
              itemWidth = (availableWidth - totalSpacing) / count;
            } else {
              // use minimum width so horizontal scrolling still works
              itemWidth = minItemWidth;
            }
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: itemWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: item.onTap,
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color:
                              item.backgroundColor ??
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            item.icon,
                            size: iconSize,
                            color:
                                item.iconColor ??
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: itemWidth,
                      child: Text(
                        item.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: spacing),
            itemCount: items.length,
          );
        },
      ),
    );
  }
}

class CarouselRoundedButtonItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  CarouselRoundedButtonItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });
}

// Removed stray trailing text
