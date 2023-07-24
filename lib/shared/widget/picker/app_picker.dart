import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/shared/shared.dart';

class AppPicker<T> extends StatelessWidget {
  const AppPicker({
    required this.options,
    super.key,
    this.height = 56,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  final double height;
  final PickerOption<T>? initialValue;
  final List<PickerOption<T>> options;
  final String? hintText;
  final void Function(PickerOption<T>?)? onChanged;
  final FormFieldValidator<PickerOption<T>>? validator;

  @override
  @override
  Widget build(BuildContext context) {
    return FormField<PickerOption<T>>(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                // _showCupertinoPicker(context, field);

                await _showCupertinoPicker(context, field);
              },
              child: Container(
                height: height,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    width: 1.4,
                    color: !field.hasError
                        ? context.colorScheme.secondary
                        : context.colorScheme.error,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: field.value != null
                          ? Text(
                              field.value!.title,
                              style: context.bodyLarge,
                            )
                          : Text(
                              hintText ?? '',
                              style: context.bodyLarge,
                            ).textColor(context.colorScheme.secondary),
                    ),
                    const SizedBox(width: 20),
                    if (field.value == null)
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                        color: !field.hasError
                            ? context.colorScheme.secondary
                            : context.colorScheme.error,
                      )
                    else
                      CupertinoButton(
                        padding: const EdgeInsets.all(2),
                        minSize: 0,
                        onPressed: () {
                          field.didChange(null);

                          onChanged?.call(null);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: !field.hasError
                              ? context.colorScheme.secondary
                              : context.colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (field.hasError) const SizedBox(height: 8),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  field.errorText ?? '',
                  style: context.labelMedium!.copyWith(
                    color: context.colorScheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _showCupertinoPicker(
    BuildContext context,
    FormFieldState<PickerOption<T>> field,
  ) async {
    var selectedOption = field.value;

    await showCupertinoModalPopup<PickerOption<T>>(
      context: context,
      builder: (context) {
        return Container(
          height: context.mqHeight / 3,
          color: context.colorScheme.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: const EdgeInsets.all(6),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Huỷ',
                      style: context.titleMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppTextButton(
                    title: 'Chọn',
                    onTap: () {
                      selectedOption ??= options.first;

                      field.didChange(selectedOption);

                      onChanged?.call(selectedOption);

                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              // Divider(color: context.colorScheme.secondary),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedOption != null
                        ? options.indexOf(selectedOption!)
                        : 0,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    selectedOption = options[selectedItem];
                  },
                  children: List<Widget>.generate(
                    options.length,
                    (int index) {
                      return Center(
                        child: Text(
                          options[index].title,
                          style: context.titleMedium,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
