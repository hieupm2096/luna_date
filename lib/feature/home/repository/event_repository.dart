import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_date/feature/home/data_source/event_lds_interface.dart';
import 'package:luna_date/feature/home/entity/event_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_repository.g.dart';

@Riverpod(keepAlive: true)
EventRepository eventRepository(EventRepositoryRef ref) => EventRepository(ref);

class EventRepository {
  const EventRepository(this.ref);

  final Ref ref;

  Future<List<EventEntity>> getEvents({required DateTime eventDate}) async {
    final result =
        await ref.read(eventLDSProvider).getEvents(eventDate: eventDate);
    final entities = result.map(EventEntity.fromModel).toList();
    return entities;
  }

  Future<EventEntity> createEvent({required EventEntity event}) async {
    final model = event.toModel();
    final result = await ref.read(eventLDSProvider).createEvent(model: model);
    return EventEntity.fromModel(result);
  }
}
