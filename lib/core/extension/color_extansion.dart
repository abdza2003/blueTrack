import 'package:flutter/material.dart';

extension ColorManager on BuildContext {
  Color get background => Theme.of(this).colorScheme.background;
  Color get onBackground => Theme.of(this).colorScheme.secondary;
  Color get border => Theme.of(this).colorScheme.onSecondary;
  Color get inverse => Theme.of(this).colorScheme.onSurface;
}
