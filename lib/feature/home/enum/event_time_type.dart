import 'package:flutter/material.dart';
import 'package:luna_date/core/extension/extensions.dart';

enum EventTimeType {
  am,
  pm,
  allDay,
  custom;

  String getEventTimeTitle(BuildContext context) {
    return switch (this) {
      am => 'Sáng',
      pm => 'Chiều tối',
      allDay => 'Cả ngày',
      custom => 'Tuỳ chỉnh',
    };
  }

  IconData get icon {
    return switch (this) {
      am => Icons.wb_sunny_outlined,
      pm => Icons.cloud_queue_rounded,
      allDay || custom => Icons.schedule,
    };
  }

  ({DateTime? startTime, DateTime? endTime}) get eventTime {
    final now = DateTime.now();

    return switch (this) {
      am => (startTime: now.startOfDay, endTime: now.halfDay),
      pm => (startTime: now.halfDay, endTime: now.endOfDay),
      allDay => (startTime: now.startOfDay, endTime: now.endOfDay),
      custom => (startTime: null, endTime: null)
    };
  }

  static EventTimeType fromTime({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    final startTimeStr = startTime.format('HH:mm');
    final endTimeStr = endTime.format('HH:mm');

    final now = DateTime.now();

    final startOfDayStr = now.startOfDay.format('HH:mm');
    final halfOfDayStr = now.halfDay.format('HH:mm');
    final endOfDayStr = now.endOfDay.floorToNearestMinute(5).format('HH:mm');

    if (startTimeStr == startOfDayStr && endTimeStr == halfOfDayStr) {
      return EventTimeType.am;
    } else if (startTimeStr == halfOfDayStr && endTimeStr == endOfDayStr) {
      return EventTimeType.pm;
    } else if (startTimeStr == startOfDayStr && endTimeStr == endOfDayStr) {
      return EventTimeType.allDay;
    } else {
      return EventTimeType.custom;
    }
  }
}
