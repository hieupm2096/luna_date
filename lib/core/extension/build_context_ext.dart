import 'package:flutter/material.dart';
import 'package:luna_date/shared/widget/widget.dart';

extension BuildContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  AppOverlay get overlay => AppOverlay();
}
