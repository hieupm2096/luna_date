import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hôm nay',
            style: context.headlineSmall,
          ).textColor(context.colorScheme.onBackground),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Thứ Ba', style: context.displayMedium)
                        .bold()
                        .textColor(context.colorScheme.onBackground),
                    Text('13.12', style: context.displayLarge)
                        .bold()
                        .textColor(context.colorScheme.onBackground),
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 24),
                const VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(width: 16),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '07.01',
                      style: context.headlineMedium,
                    ).textColor(context.colorScheme.onBackground),
                    Text(
                      'Dương Lịch',
                      style: context.titleSmall,
                    ).textColor(context.colorScheme.onBackground),
                    const SizedBox(height: 16),
                    Text(
                      '06:20',
                      style: context.headlineMedium,
                    ).textColor(context.colorScheme.onBackground),
                    Text(
                      'GMT+7',
                      style: context.titleSmall,
                    ).textColor(context.colorScheme.onBackground),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
