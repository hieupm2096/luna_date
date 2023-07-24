import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_date/feature/home/controller/create_event_controller.dart';
import 'package:luna_date/feature/home/widget/create_event_form.dart';
import 'package:luna_date/shared/shared.dart';

class CreateEventModal extends ConsumerWidget {
  const CreateEventModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCreateEvent = ref.watch(createEventControllerProvider);

    return AbsorbPointer(
      absorbing: asyncCreateEvent.isLoading,
      child: const AppModal(
        title: 'Thêm sự kiện',
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: CreateEventForm(),
          ),
        ),
      ),
    );
  }
}
