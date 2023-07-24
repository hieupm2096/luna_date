import 'package:hive_flutter/hive_flutter.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class EventModel {
  const EventModel({
    this.id,
    this.title,
    this.eventDateTime,
    this.startTime,
    this.endTime,
    this.category,
    this.repeat,
    this.repeatType,
    this.note,
  });

  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final DateTime? eventDateTime; // Event date (solar)

  @HiveField(3)
  final DateTime? startTime;

  @HiveField(4)
  final DateTime? endTime;

  @HiveField(5)
  final String? category;

  @HiveField(6)
  final bool? repeat;

  @HiveField(7)
  final String? repeatType;

  @HiveField(8)
  final String? note;
}
