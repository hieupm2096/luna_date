import 'package:flutter/cupertino.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:luna_date/core/extension/build_context_ext.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    super.key,
    this.onTap,
    this.buttonColor,
    this.buttonShadowColor,
    this.height = 64,
    this.width,
    this.borderRadius,
    this.isLoading = false,
  });

  factory PrimaryButton.small({
    required Widget title,
    VoidCallback? onTap,
    double? width,
    bool isLoading = false,
  }) =>
      PrimaryButton(
        title: title,
        onTap: onTap,
        height: 46,
        width: width,
        borderRadius: BorderRadius.circular(18),
        isLoading: isLoading,
      );

  final Widget title;
  final double height;
  final double? width;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? buttonShadowColor;
  final BorderRadius? borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final buttonShadowColor = onTap != null
        ? this.buttonShadowColor ?? context.colorScheme.primaryContainer
        : context.colorScheme.secondaryContainer;

    final buttonColor = onTap != null
        ? this.buttonColor ?? context.colorScheme.primary
        : context.colorScheme.secondary;

    return Bounceable(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          color: buttonShadowColor,
        ),
        child: Container(
          height: height - 4,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(20),
            color: buttonColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title,
                if (isLoading) const SizedBox(width: 12),
                if (isLoading)
                  CupertinoActivityIndicator(
                    color: context.colorScheme.onPrimary,
                    radius: 8,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
