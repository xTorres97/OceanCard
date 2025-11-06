import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SelectionWidget<T> extends StatefulWidget {
  final List<T> items;
  final T selectedValue;
  final Widget Function(T item) cardItemBuilder; // For cards style
  final Widget Function(T item)?
  fullCardItemBuilder; // For full balance cards (style 1)
  final String Function(T item) dropdownTextBuilder; // For dropdown style text
  final void Function(T? value) onChanged;
  final int style;
  final String? dropdownHintText;

  const SelectionWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.cardItemBuilder,
    this.fullCardItemBuilder,
    required this.dropdownTextBuilder,
    required this.onChanged,
    this.style = 2, // Default to 2 (selection buttons)
    this.dropdownHintText,
  });

  @override
  State<SelectionWidget<T>> createState() => _SelectionWidgetState<T>();
}

class _SelectionWidgetState<T> extends State<SelectionWidget<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.style == 1) {
      return _buildFullCards();
    } else {
      return _buildSelectionButtons();
    }
  }

  Widget _buildFullCards() {
    // Estilo 1: Cards completas con balance y avatar (PageView scrollable)
    final selectedIndex = widget.items.indexOf(widget.selectedValue);

    return SizedBox(
      height: 150, // Altura suficiente para las cards completas
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: PageView.builder(
          itemCount: widget.items.length,
          controller: PageController(
            viewportFraction: 0.85,
            initialPage: selectedIndex >= 0 ? selectedIndex : 0,
          ),
          physics: const BouncingScrollPhysics(), // Mejor experiencia de scroll
          padEnds: false, // Permite que las cards se vean en los bordes
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    widget.fullCardItemBuilder?.call(item) ??
                    widget.cardItemBuilder(item),
              ),
            );
          },
          onPageChanged: (index) {
            widget.onChanged(widget.items[index]);
          },
        ),
      ),
    );
  }

  Widget _buildSelectionButtons() {
    // Estilo 2: Botones pequeños de selección con scroll horizontal
    return SizedBox(
      height: 80,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return GestureDetector(
              onTap: () => widget.onChanged(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: widget.cardItemBuilder(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
