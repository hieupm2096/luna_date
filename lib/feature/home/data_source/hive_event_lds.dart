import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_date/bootstrap.dart';
import 'package:luna_date/core/extension/extensions.dart';
import 'package:luna_date/feature/home/data_source/event_lds_interface.dart';
import 'package:luna_date/feature/home/model/event_model.dart';

class HiveEventLDS implements IEventLocalDataSource {
  const HiveEventLDS(this.ref);

  final Ref ref;

  @override
  Future<EventModel> createEvent({required EventModel model}) async {
    await ref.read(eventBoxProvider).put(model.id, model);
    return model;
  }

  @override
  Future<void> deleteEvent({required String id}) async {
    await ref.read(eventBoxProvider).delete(id);
  }

  @override
  Future<List<EventModel>> getEvents({DateTime? eventDate}) async {
    final events = ref.read(eventBoxProvider).values;

    if (eventDate == null) {
      return events.toList();
    }

    return events
        .where((element) => element.eventDateTime?.sameDay(eventDate) ?? false)
        .toList();
  }

  @override
  Future<EventModel> updateEvent({
    required String id,
    required EventModel model,
  }) async {
    await ref.read(eventBoxProvider).put(id, model);
    return model;
  }
}
