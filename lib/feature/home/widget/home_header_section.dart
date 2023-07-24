import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({
    super.key,
  });

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    _now = DateTime.now();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _now = _now.add(const Duration(seconds: 1));
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                    Text(
                      _now.format('EEEE'),
                      style: context.displayMedium,
                    ).bold().textColor(context.colorScheme.onBackground),
                    Text(
                      _now.lunarDate.format('dd.MM'),
                      style: context.displayLarge,
                    ).bold().textColor(context.colorScheme.onBackground),
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 20),
                const VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(width: 20),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _now.format('dd.MM'),
                      style: context.headlineMedium,
                    ).textColor(context.colorScheme.onBackground),
                    Text(
                      'Dương Lịch',
                      style: context.titleSmall,
                    ).textColor(context.colorScheme.onBackground),
                    const SizedBox(height: 16),
                    Text(
                      _now.format('HH:mm'),
                      style: context.headlineMedium,
                    ).textColor(context.colorScheme.onBackground),
                    Text(
                      'GMT+${_now.timeZoneOffset.inHours.padZero(2)}',
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
