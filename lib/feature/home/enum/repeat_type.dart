import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum RepeatType {
  daily('daily'),
  weekly('weekly'),
  monthly('monthly'),
  yearly('yearly');

  const RepeatType(this.value);

  final String value;

  String getTitle(BuildContext context) {
    return switch (this) {
      RepeatType.daily => 'Hàng ngày',
      RepeatType.weekly => 'Hàng tuần',
      RepeatType.monthly => 'Hàng tháng',
      RepeatType.yearly => 'Hàng năm'
    };
  }

  static RepeatType? fromValue(String value) {
    return RepeatType.values
        .firstWhereOrNull((element) => element.value == value);
  }
}
