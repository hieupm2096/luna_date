import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_date/app/router/router.dart';
import 'package:luna_date/gen/fonts.gen.dart';
import 'package:luna_date/l10n/l10n.dart';
import 'package:luna_date/shared/shared.dart';

final _botToastBuilder = BotToastInit();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);

    return Portal(
      child: MaterialApp.router(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
          physics: const BouncingScrollPhysics(),
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xff735bf2),
          canvasColor: Colors.transparent,
          fontFamily: FontFamily.oswald,
          textTheme: appTextTheme,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: _botToastBuilder,
        routerConfig: router,
      ),
    );
  }
}
