import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    super.key,
    this.radius = 12,
    this.border,
    this.padding,
    this.backgroundColor,
    this.textColor,
  });

  final String label;
  final double radius;
  final Border? border;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(10, 2, 10, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: border ??
            Border.all(color: context.colorScheme.onTertiaryContainer),
        color: backgroundColor,
      ),
      child: Text(
        label.toLowerCase(),
        style: context.titleSmall!.copyWith(
          color: textColor ?? context.colorScheme.onSecondaryContainer,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
