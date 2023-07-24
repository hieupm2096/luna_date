import 'package:luna_date/feature/home/enum/event_time_type.dart';
import 'package:luna_date/feature/home/enum/repeat_type.dart';
import 'package:luna_date/feature/home/model/event_model.dart';

class EventEntity {
  const EventEntity({
    required this.id,
    required this.title,
    required this.eventDateTime,
    required this.repeat,
    required this.startTime,
    required this.endTime,
    required this.eventTimeType,
    this.category,
    this.repeatType,
    this.note,
  });

  factory EventEntity.fromModel(EventModel model) {
    final id = model.id;
    final title = model.title;
    final eventDateTime = model.eventDateTime;
    final startTime = model.startTime;
    final endTime = model.endTime;
    final repeat = model.repeat ?? false;
    if (id == null ||
        title == null ||
        eventDateTime == null ||
        startTime == null ||
        endTime == null) {
      throw Exception('EventModel exception');
    }

    final eventTimeType =
        EventTimeType.fromTime(startTime: startTime, endTime: endTime);

    RepeatType? repeatType;
    if (repeat && model.repeatType != null) {
      repeatType = RepeatType.fromValue(model.repeatType!);
    }

    return EventEntity(
      id: id,
      title: title,
      eventDateTime: eventDateTime,
      category: model.category,
      startTime: startTime,
      endTime: endTime,
      eventTimeType: eventTimeType,
      repeat: repeat,
      repeatType: repeatType,
      note: model.note,
    );
  }

  final String id;
  final String title;
  final String? category;
  final DateTime eventDateTime;
  final DateTime startTime;
  final DateTime endTime;
  final EventTimeType eventTimeType;
  final bool repeat;
  final RepeatType? repeatType;
  final String? note;

  EventModel toModel() {
    return EventModel(
      id: id,
      title: title,
      category: category,
      eventDateTime: eventDateTime,
      startTime: startTime,
      endTime: endTime,
      repeat: repeat,
      repeatType: repeatType?.value,
      note: note,
    );
  }
}
