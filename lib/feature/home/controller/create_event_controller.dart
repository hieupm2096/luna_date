import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/controller/list_event_controller.dart';
import 'package:luna_date/feature/home/entity/event_entity.dart';
import 'package:luna_date/feature/home/enum/event_time_type.dart';
import 'package:luna_date/feature/home/enum/repeat_type.dart';
import 'package:luna_date/feature/home/repository/event_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'create_event_controller.g.dart';

@riverpod
class CreateEventController extends _$CreateEventController {
  @override
  FutureOr<EventEntity?> build() => null;

  Future<void> createEvent({
    required String title,
    required DateTime eventDate,
    required DateTime startTime,
    required DateTime endTime,
    required EventTimeType eventTimeType,
    required bool repeat,
    String? category,
    RepeatType? repeatType,
    String? note,
  }) async {
    state = const AsyncLoading();

    final entity = EventEntity(
      id: const Uuid().v4(),
      title: title,
      eventDateTime: eventDate,
      startTime: startTime,
      endTime: endTime,
      eventTimeType: eventTimeType,
      repeat: repeat,
      category: category,
      repeatType: repeatType,
      note: note,
    );

    state = await AsyncValue.guard(
      () async {
        final result =
            await ref.read(eventRepositoryProvider).createEvent(event: entity);

        // update local event list controller
        if (ref.exists(
          listEventControllerProvider(eventDate.format('dd/MM/yyyy')),
        )) {
          ref
              .read(
                listEventControllerProvider(eventDate.format('dd/MM/yyyy'))
                    .notifier,
              )
              .addNewEvent(result);
        }

        return result;
      },
    );
  }
}
