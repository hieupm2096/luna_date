import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/entity/event_entity.dart';
import 'package:luna_date/feature/home/enum/event_time_type.dart';
import 'package:luna_date/shared/shared.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    super.key,
  });

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.colorScheme.tertiaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (event.category != null) AppChip(label: event.category!),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            event.title,
            style: context.headlineLarge,
          ).textColor(context.colorScheme.onTertiaryContainer).bold(),
          const SizedBox(height: 32),
          Row(
            children: [
              _IconDescription(
                icon: Icon(event.eventTimeType.icon, size: 16),
                label: event.eventTimeType != EventTimeType.custom
                    ? event.eventTimeType.getEventTimeTitle(context)
                    : '${event.startTime.format('HH:mm')}-'
                        '${event.endTime.format('HH:mm')}',
              ),
              const Spacer(),
              if (event.repeat) const SizedBox(width: 24),
              if (event.repeat)
                _IconDescription(
                  icon: const Icon(Icons.repeat, size: 16),
                  label: event.repeatType?.getTitle(context) ?? '',
                ),
              const Spacer(),
              const SizedBox(width: 48),
              Text(
                '•',
                style: context.headlineSmall!.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconDescription extends StatelessWidget {
  const _IconDescription({
    required this.icon,
    required this.label,
  });

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          label,
          style: context.labelLarge,
        ),
      ],
    );
  }
}
