import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/shared/shared.dart';

class AppModal extends StatelessWidget {
  const AppModal({
    required this.title,
    required this.child,
    super.key,
    this.leading,
    this.trailing,
  });

  final Widget? leading;
  final String title;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: CupertinoPageScaffold(
        backgroundColor: context.colorScheme.background,
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: context.colorScheme.background,
          leading: leading ?? const AppCloseButton(),
          middle: Text(
            title,
            style: context.titleLarge,
          ),
          trailing: trailing,
        ),
        child: child,
      ),
    );
  }
}
