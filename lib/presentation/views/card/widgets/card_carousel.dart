import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocean_card/core/configuration/tema/tema_cubit.dart';
import '../../../../data/models/card_model.dart';
import 'scroll_behavior.dart';

class CardCarousel extends StatelessWidget {
  final List<CardModel> cards;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const CardCarousel({
    super.key,
    required this.cards,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < 0 && currentIndex < cards.length - 1) {
            onChanged(currentIndex + 1);
          } else if (details.primaryVelocity! > 0 && currentIndex > 0) {
            onChanged(currentIndex - 1);
          }
        },
        child: ScrollConfiguration(
          behavior: HomeCardCarouselScrollBehavior(),
          child: PageView.builder(
            controller: PageController(initialPage: currentIndex),
            itemCount: cards.length,
            onPageChanged: onChanged,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(
                  horizontal: index == currentIndex ? 0 : 16,
                  vertical: index == currentIndex ? 0 : 16,
                ),
                child: BlocBuilder<TemaCubit, bool>(
                  builder: (context, state) {
                    return SvgPicture.asset(
                      state ? 'assets/card_white.svg' : 'assets/card_black.svg',
                      fit: BoxFit.contain,
                      width: 250,
                      height: 173,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
