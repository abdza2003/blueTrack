import 'package:flutter/material.dart';

class CustomAnimatedWidgetKit extends StatefulWidget {
  final List<Widget> widgets;
  final Duration switchDuration;
  final Duration transitionDuration;
  final Curve curve;

  const CustomAnimatedWidgetKit({
    super.key,
    required this.widgets,
    this.switchDuration = const Duration(seconds: 2),
    this.transitionDuration = const Duration(seconds: 2),
    this.curve = Curves.easeInOut,
  });

  @override
  _CustomAnimatedWidgetKitState createState() =>
      _CustomAnimatedWidgetKitState();
}

class _CustomAnimatedWidgetKitState extends State<CustomAnimatedWidgetKit> {
  late ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier<int>(0);
    _startAnimation();
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _startAnimation() {
    Future.delayed(widget.switchDuration, _nextWidget);
  }

  void _nextWidget() {
    if (mounted) {
      _currentIndexNotifier.value =
          (_currentIndexNotifier.value + 1) % widget.widgets.length;
      _startAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Stack(
          alignment: Alignment.center,
          children: widget.widgets.asMap().entries.map((entry) {
            final isCurrent = entry.key == currentIndex;
            return AnimatedPositioned(
              key: ValueKey(entry.key),
              duration: widget.transitionDuration,
              curve: widget.curve,
              top: isCurrent
                  ? 0
                  : -MediaQuery.of(context)
                      .size
                      .height, // Moves widget from top to center
              child: AnimatedOpacity(
                opacity: isCurrent ? 1.0 : 0.0,
                duration: widget.transitionDuration,
                curve: widget.curve,
                child: entry.value,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
