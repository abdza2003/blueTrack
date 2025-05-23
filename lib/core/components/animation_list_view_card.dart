import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationListViewCard extends StatelessWidget {
  final int index;
  final Widget child;
  final int durationMilliseconds;
  final double verticalOffset;
  const AnimationListViewCard(
      {required this.index,
      required this.child,
      this.verticalOffset = 100.0,
      this.durationMilliseconds = 300,
      super.key});
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: durationMilliseconds),
      child: SlideAnimation(
        verticalOffset: verticalOffset,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
