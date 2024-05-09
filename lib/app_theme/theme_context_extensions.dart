import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  //text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  //color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
