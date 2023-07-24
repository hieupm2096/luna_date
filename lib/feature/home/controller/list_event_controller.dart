import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/entity/event_entity.dart';
import 'package:luna_date/feature/home/repository/event_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_event_controller.g.dart';

@Riverpod(keepAlive: true)
class ListEventController extends _$ListEventController {
  @override
  FutureOr<List<EventEntity>> build(String eventDate) async {
    final eventDateTime =
        DateTimeExt.tryParseFormat(value: eventDate, format: 'dd/MM/yyyy');

    final result = await AsyncValue.guard(
      () => ref
          .read(eventRepositoryProvider)
          .getEvents(eventDate: eventDateTime!),
    );

    return result.value ?? [];
  }

  void addNewEvent(EventEntity event) {
    if (state.value != null) {
      state.value!.insert(0, event);
    }
  }
}
