import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.height = 64,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  final double height;
  final DateTime? initialValue;
  final String? hintText;
  final void Function(DateTime)? onChanged;
  final FormFieldValidator<DateTime>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
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

                final initialDate = field.value;

                final result = await showCalendarDatePicker2Dialog(
                  context: context,
                  value: initialDate != null ? [initialDate] : [],
                  dialogBackgroundColor: context.colorScheme.background,
                  dialogSize: Size(context.mqWidth - 32, 400),
                  borderRadius: BorderRadius.circular(15),
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    firstDayOfWeek: 1,
                    calendarType: CalendarDatePicker2Type.single,
                    selectedDayHighlightColor: context.colorScheme.primary,
                    okButtonTextStyle: context.titleMedium!.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    cancelButtonTextStyle: context.bodyMedium!.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                    dayBuilder: ({
                      required DateTime date,
                      decoration,
                      isDisabled,
                      isSelected,
                      isToday,
                      textStyle,
                    }) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ?? false
                              ? context.colorScheme.primary
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          border: (isToday ?? false)
                              ? Border.all(color: context.colorScheme.secondary)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.format('dd'),
                              style: context.bodyLarge!.copyWith(
                                color: isSelected ?? false
                                    ? context.colorScheme.onPrimary
                                    : context.colorScheme.onBackground,
                                fontSize: 16,
                                height: 1,
                              ),
                            ),
                            Text(
                              date.lunarDate.isStartOfMonth
                                  ? date.lunarDate.format('dd/MM')
                                  : date.lunarDate.format('dd'),
                              style: context.labelSmall!.copyWith(
                                color: isSelected ?? false
                                    ? context.colorScheme.onPrimary
                                    : date.lunarDate.isStartOfMonth ||
                                            date.lunarDate.isHalfMonth
                                        ? context.colorScheme.primary
                                        : context.colorScheme.secondary,
                                fontSize: 10,
                                height: 12 / 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );

                field.didChange(result?.firstOrNull);

                if (result != null &&
                    result.isNotEmpty &&
                    result.first != null) {
                  onChanged?.call(result.first!);
                }
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
                              field.value!.lunarDate.format('dd/MM/yyyy'),
                              style: context.bodyLarge,
                            )
                          : Text(
                              hintText ?? '',
                              style: context.bodyLarge,
                            ).textColor(context.colorScheme.secondary),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.calendar_month,
                      size: 24,
                      color: !field.hasError
                          ? context.colorScheme.secondary
                          : context.colorScheme.error,
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
}
