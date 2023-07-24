import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/controller/create_event_controller.dart';
import 'package:luna_date/feature/home/enum/event_time_type.dart';
import 'package:luna_date/feature/home/enum/repeat_type.dart';
import 'package:luna_date/shared/shared.dart';

class CreateEventForm extends ConsumerStatefulWidget {
  const CreateEventForm({super.key});

  @override
  ConsumerState<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends ConsumerState<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _eventDate;
  String? _category;
  EventTimeType _eventTimeType = EventTimeType.am;
  DateTime? _startTime;
  DateTime? _endTime;
  bool _repeat = false;
  RepeatType? _repeatType;
  final _noteController = TextEditingController();

  @override
  void initState() {
    _startTime = _eventTimeType.eventTime.startTime?.floorToNearestMinute(5);
    _endTime = _eventTimeType.eventTime.endTime?.floorToNearestMinute(5);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncCreateEvent = ref.watch(createEventControllerProvider);

    ref.listen(
      createEventControllerProvider,
      (previous, next) {
        if (next.isLoading) {
        } else if (next.hasError && next.error != null) {
          context.overlay.showError(
            context: context,
            content: next.error!.toString(),
          );
        } else if (next.hasValue && next.value != null) {
          context.overlay.showToast(
            context: context,
            content: 'Thêm sự kiện thành công',
          );
          context.pop<void>();
        }
      },
    );

    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // TITLE
            PrimaryTextFormField.large(
              context: context,
              controller: _titleController,
              hintText: 'Tên sự kiện',
              validator: RequiredValidator(errorText: 'Nhập Tên sự kiện').call,
            ),
            const SizedBox(height: 20),

            // LUNAR DATE
            DatePicker(
              hintText: 'Ngày âm lịch',
              initialValue: _eventDate,
              validator:
                  FieldRequiredValidator<DateTime?>('Chọn ngày âm lịch').call,
              onChanged: (value) {
                _eventDate = value;
              },
            ),
            const SizedBox(height: 28),

            // CATEGORIES
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Danh mục',
                    style: context.titleMedium,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: AppPicker<String>(
                    hintText: 'Chọn danh mục',
                    options: categories.map(StringPickerOption.new).toList(),
                    onChanged: (option) {
                      _category = option?.value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // EVENT TIME TYPE
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Thời gian',
                  style: context.titleMedium,
                ),
                const SizedBox(width: 16),
                const Spacer(),
                CupertinoSlidingSegmentedControl<EventTimeType>(
                  groupValue: _eventTimeType,
                  children: EventTimeType.values.asMap().map(
                        (key, value) => MapEntry(
                          value,
                          Text(value.getEventTimeTitle(context)),
                        ),
                      ),
                  onValueChanged: (value) {
                    setState(() {
                      _eventTimeType = value ?? _eventTimeType;
                      _startTime = _eventTimeType.eventTime.startTime
                          ?.floorToNearestMinute(5);
                      _endTime = _eventTimeType.eventTime.endTime
                          ?.floorToNearestMinute(5);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_eventTimeType == EventTimeType.custom)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TimePicker(
                      hintText: 'Bắt đầu',
                      enabled: _eventTimeType == EventTimeType.custom,
                      initialValue: _startTime,
                      validator: (value) {
                        if (value == null) return 'Chọn thời gian bắt đầu';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() => _startTime = value);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TimePicker(
                      hintText: 'Kết thúc',
                      enabled: _eventTimeType == EventTimeType.custom,
                      initialValue: _endTime,
                      validator: (value) {
                        if (value == null) return 'Chọn thời gian kết thúc';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() => _endTime = value);
                      },
                    ),
                  ),
                ],
              ),
            if (_eventTimeType == EventTimeType.custom)
              const SizedBox(height: 28),

            // REPEAT
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Lặp lại',
                  style: context.titleMedium,
                ),
                const SizedBox(width: 16),
                const Spacer(),
                Switch(
                  value: _repeat,
                  onChanged: (value) {
                    setState(() {
                      if (!_repeat) {
                        _repeatType = RepeatType.daily;
                      }
                      _repeat = value;
                    });
                  },
                ),
              ],
            ),
            if (_repeat) const SizedBox(height: 16),

            AnimatedSwitcher(
              duration: 250.milliseconds,
              child: _repeat
                  ? CupertinoSlidingSegmentedControl<RepeatType>(
                      groupValue: _repeatType,
                      children: RepeatType.values.asMap().map(
                            (key, value) => MapEntry(
                              value,
                              Text(
                                value.getTitle(context),
                                style: context.bodyLarge,
                              ),
                            ),
                          ),
                      onValueChanged: (value) {
                        setState(() => _repeatType = value);
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 28),

            // NOTE
            PrimaryTextFormField.large(
              context: context,
              minLines: 4,
              controller: _noteController,
              hintText: 'Chú thích...',
            ),
            const SizedBox(height: 32),

            // SUBMIT BUTTON
            PrimaryButton(
              isLoading: asyncCreateEvent.isLoading,
              title: Text(
                'Thêm sự kiện',
                style: context.titleLarge!
                    .copyWith(color: context.colorScheme.onPrimary),
              ),
              onTap: _onSubmit,
            ),
            SizedBox(height: context.mqViewPadding.bottom + 24),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(createEventControllerProvider.notifier).createEvent(
          title: _titleController.text,
          eventDate: _eventDate!,
          startTime: _startTime!,
          endTime: _endTime!,
          eventTimeType: _eventTimeType,
          repeat: _repeat,
          repeatType: _repeatType,
          category: _category,
          note: _noteController.text,
        );
  }
}
