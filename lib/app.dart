import 'package:flutter/material.dart';
import 'package:just_in_play_proof/core/third_part/router/just_play_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
