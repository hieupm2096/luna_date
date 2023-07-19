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

  String format(String format, {String? locale}) {
    return DateFormat(format, locale ?? 'vi_VN').format(this);
  }
}
