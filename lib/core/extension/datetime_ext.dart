import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

extension DateTimeExt on DateTime {
  DateTime get lunarDate {
    final solar = Solar(solarYear: year, solarMonth: month, solarDay: day);
    final lunar = LunarSolarConverter.solarToLunar(solar);
    return DateTime(
      lunar.lunarYear ?? 0,
      lunar.lunarMonth ?? 0,
      lunar.lunarDay ?? 0,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  bool get isStartOfMonth => day == 1;

  bool get isHalfMonth => day == 15;

  String format(String format, {String? locale}) {
    return DateFormat(format, locale ?? 'vi_VN').format(this);
  }

  DateTime floorToNearestMinute(int nearestMinutes) {
    // Calculate the number of nearest-minute intervals
    final intervals = minute ~/ nearestMinutes;

    // Calculate the rounded minutes
    final roundedMinutes = nearestMinutes * intervals;

    // Create a new DateTime object with the rounded minutes
    final flooredDateTime = DateTime(
      year,
      month,
      day,
      hour,
      roundedMinutes,
    );

    // // Check if we need to round up to the next nearestMinutes
    // if (minute % nearestMinutes >= nearestMinutes / 2) {
    //   roundedDateTime = roundedDateTime
    //      .add(Duration(minutes: nearestMinutes));
    // }

    return flooredDateTime;
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTime get halfDay {
    return DateTime(year, month, day, 12);
  }

  bool sameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;

  static DateTime? tryParseFormat({
    required String value,
    required String format,
  }) {
    try {
      return DateFormat(format).parse(value);
    } on Exception {
      return null;
    }
  }
}

extension LunarExt on Lunar {
  DateTime get solarDate {
    final solar = LunarSolarConverter.lunarToSolar(this);
    return solar.dateTime;
  }
}
