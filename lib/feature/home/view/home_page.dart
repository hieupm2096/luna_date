import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/controller/create_event_controller.dart';
import 'package:luna_date/feature/home/controller/list_event_controller.dart';
import 'package:luna_date/feature/home/view/create_event_modal.dart';
import 'package:luna_date/feature/home/widget/event_card.dart';
import 'package:luna_date/feature/home/widget/home_header_section.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static String route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCreateEvent = ref.watch(createEventControllerProvider);

    final asyncListEvent = ref.watch(
      listEventControllerProvider(DateTime.now().format('dd/MM/yyyy')),
    );

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CupertinoScaffold.showCupertinoModalBottomSheet<dynamic>(
            context: context,
            expand: true,
            enableDrag: !asyncCreateEvent.isLoading,
            builder: (context) => const CreateEventModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.mqViewPadding.top),
            const HomeHeaderSection(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Sự kiện',
                      style: context.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  asyncListEvent.when(
                    data: (data) {
                      if (data.isEmpty) {
                        // return empty widget
                        return const SizedBox.shrink();
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: EventCard(event: e),
                              ),
                            )
                            .toList(),
                      );
                    },
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                  ),
                  SizedBox(height: context.mqViewPadding.bottom + 88),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
