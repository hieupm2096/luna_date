import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:luna_date/core/core.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.title,
    super.key,
    this.icon,
    this.color,
    this.onTap,
  });

  final String title;
  final Widget? icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(6),
      onPressed: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.titleMedium,
          ).textColor(color ?? context.colorScheme.primary),
          icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
