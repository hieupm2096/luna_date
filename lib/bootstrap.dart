import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:luna_date/feature/home/model/event_model.dart';

final eventBoxProvider =
    Provider<Box<EventModel>>((_) => throw UnimplementedError());

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  // Add cross-flavor configuration here
  await Hive.initFlutter();

  Hive.registerAdapter(EventModelAdapter());
  final eventBox = await Hive.openBox<EventModel>('eventBox');

  final container = ProviderContainer(
    overrides: [
      eventBoxProvider.overrideWithValue(eventBox),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: await builder(),
    ),
  );
}
