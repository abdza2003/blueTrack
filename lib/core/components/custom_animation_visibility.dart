import 'package:flutter/material.dart';

class CustomAnimationVisibility extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Widget? replacement;
  final Duration duration;
  const CustomAnimationVisibility(
      {this.visible = true,
      required this.child,
      this.replacement,
      this.duration = const Duration(milliseconds: 200),
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: visible ? 1.0 : 0.0,
      child: Visibility(
        replacement: replacement ?? const SizedBox(),
        visible: visible,
        child: child,
      ),
    );
  }
}
