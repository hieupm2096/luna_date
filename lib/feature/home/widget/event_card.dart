import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/shared/shared.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

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
          const Row(
            children: [
              AppChip(label: 'lễ hội'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Trung Thu',
            style: context.headlineLarge,
          ).textColor(context.colorScheme.onTertiaryContainer).bold(),
          const SizedBox(height: 32),
          Row(
            children: [
              const _IconDescription(
                icon: Icon(Icons.alarm, size: 16),
                label: 'Cả ngày',
              ),
              const Spacer(),
              const SizedBox(width: 24),
              const _IconDescription(
                icon: Icon(Icons.repeat, size: 16),
                label: 'Hàng năm',
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
