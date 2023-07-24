import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:luna_date/feature/home/home.dart';
import 'package:luna_date/feature/splash/splash.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> goRouter(GoRouterRef ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    observers: [
      BotToastNavigatorObserver(),
    ],
    routes: [
      // SPLASH PAGE
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) => const SplashPage(),
      ),

      // HOME PAGE
      GoRoute(
        path: HomePage.route,
        builder: (context, state) {
          // wrap your page with CupertinoScaffold
          return const CupertinoScaffold(
            body: HomePage(),
          );
        },
      ),
    ],
  );
}
