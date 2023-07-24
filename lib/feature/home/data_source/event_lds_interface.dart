import 'package:luna_date/feature/home/data_source/hive_event_lds.dart';
import 'package:luna_date/feature/home/model/event_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_lds_interface.g.dart';

@Riverpod(keepAlive: true)
IEventLocalDataSource eventLDS(EventLDSRef ref) => HiveEventLDS(ref);

abstract interface class IEventLocalDataSource {
  Future<List<EventModel>> getEvents({DateTime? eventDate});

  Future<EventModel> createEvent({required EventModel model});

  Future<EventModel> updateEvent({
    required String id,
    required EventModel model,
  });

  Future<void> deleteEvent({required String id});
}
