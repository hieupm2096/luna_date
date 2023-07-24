import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luna_date/core/core.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (onTap != null) {
          onTap!.call();
        } else {
          context.pop();
        }
      },
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 24,
        color: context.colorScheme.onBackground,
      ),
    );
  }
}
