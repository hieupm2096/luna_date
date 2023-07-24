import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';

class PrimaryTextFormField extends StatefulWidget {
  const PrimaryTextFormField({
    required this.context,
    super.key,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.keyboardType,
    this.enabled = true,
    this.obscureText,
    this.hintText,
    this.prefixIcon,
    this.style,
    this.hintTextStyle,
    this.filledColor,
    this.borderRadius = 16,
    this.contentPadding,
    this.borderSide,
    this.onTap,
    this.minLines,
    this.maxLines,
    this.validator,
    this.onChanged,
  });

  factory PrimaryTextFormField.large({
    required BuildContext context,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool enabled = true,
    bool? obscureText,
    String? hintText,
    Widget? prefixIcon,
    int? minLines,
    int? maxLines,
    String? Function(String?)? validator,
  }) =>
      PrimaryTextFormField(
        context: context,
        controller: controller,
        enabled: enabled,
        obscureText: obscureText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        keyboardType: keyboardType,
        style: context.bodyLarge,
        contentPadding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
        borderRadius: 24,
        borderSide: BorderSide(
          width: 1.4,
          color: context.colorScheme.secondary,
        ),
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
      );

  final BuildContext context;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool? obscureText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextStyle? hintTextStyle;
  final Color? filledColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final BorderSide? borderSide;
  final VoidCallback? onTap;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<PrimaryTextFormField> createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {
  late final TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _obscureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      // cursorColor: $style.colors.textFieldCursor,
      style: widget.style ?? context.bodyMedium,
      onTap: widget.onTap,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        // hintStyle: (widget.hintTextStyle
        //             ?? widget.style
        //             ?? context.bodyMedium)!
        //     .copyWith(
        //   color: context.colorScheme.secondary,
        // ),
        errorStyle: context.labelMedium!.copyWith(
          color: context.colorScheme.error,
        ),
        alignLabelWithHint: true,
        filled: true,
        fillColor: context.colorScheme.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: (widget.borderSide ?? BorderSide.none).copyWith(
            color: context.colorScheme.error,
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            widget.prefixIcon != null ? 12 : 0,
            0,
          ),
          child: widget.prefixIcon,
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 24,
          maxHeight: 24,
        ),
        suffixIcon: _buildSuffixIcon(),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 24,
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }

  Widget? _buildSuffixIcon() {
    if (_controller.text.isNotEmpty && widget.enabled) {
      if (widget.obscureText ?? false) {
        return _PasswordVisibilityButton(
          visible: _obscureText,
          onTap: () => setState(() => _obscureText = !_obscureText),
        );
      }
      return _ClearButton(onTap: _controller.clear);
    }
    return null;
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: const Icon(Icons.close, size: 16),
    );
  }
}

class _PasswordVisibilityButton extends StatelessWidget {
  const _PasswordVisibilityButton({
    this.visible = false,
    this.onTap,
  });

  final bool visible;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: visible
          ? const Icon(Icons.visibility_outlined)
          : const Icon(Icons.visibility_off_outlined),
    );
  }
}
