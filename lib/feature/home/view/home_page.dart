import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/core.dart';
import 'package:luna_date/feature/home/widget/event_card.dart';
import 'package:luna_date/feature/home/widget/home_header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
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
                  EventCard(),
                  const SizedBox(height: 20),
                  EventCard(),
                  const SizedBox(height: 20),
                  EventCard(),
                  const SizedBox(height: 20),
                  EventCard(),
                  SizedBox(height: context.mqViewPadding.bottom + 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
