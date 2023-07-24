import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/shared/shared.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    this.enabled = true,
    this.height = 60,
    this.initialValue,
    this.minimumDate,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  final bool enabled;
  final double height;
  final DateTime? initialValue;
  final String? hintText;
  final void Function(DateTime)? onChanged;
  final DateTime? minimumDate;
  final FormFieldValidator<DateTime>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (field) {
        final value = initialValue ?? field.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed:
                  enabled ? () => _showCupertinoPicker(context, field) : null,
              child: Container(
                height: height,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    width: 1.4,
                    color: !field.hasError
                        ? enabled
                            ? context.colorScheme.secondary
                            : context.colorScheme.secondaryContainer
                        : context.colorScheme.error,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: value != null
                          ? Text(
                              value.lunarDate.format('HH:mm'),
                              style: context.bodyLarge,
                            )
                          : Text(
                              hintText ?? '',
                              style: context.bodyLarge,
                            ).textColor(context.colorScheme.secondary),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.schedule_rounded,
                      size: 24,
                      color: enabled
                          ? context.colorScheme.onBackground
                          : context.colorScheme.secondaryContainer,
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
    FormFieldState<DateTime> field,
  ) async {
    var value =
        field.value ?? initialValue ?? DateTime.now().floorToNearestMinute(5);

    await showCupertinoModalPopup<DateTime>(
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
                      field.didChange(value);

                      onChanged?.call(value);

                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              // Divider(color: context.colorScheme.secondary),
              Expanded(
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: value,
                  minuteInterval: 5,
                  minimumDate: minimumDate,
                  onDateTimeChanged: (date) {
                    value = date;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
