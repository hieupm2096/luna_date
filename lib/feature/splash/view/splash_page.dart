import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luna_date/feature/home/view/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static String route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        context.go(HomePage.route);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Text(SplashPage.route),
      ),
    );
  }
}
