import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/app.dart';
import 'package:just_in_play_proof/core/common/env/env_conf.dart';
import 'package:just_in_play_proof/core/core_config/network/provider/network_provider.dart';

import 'package:just_in_play_proof/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConf.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final container = ProviderContainer();
  container.read(justNetworkProvider).dioConfig();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );
}
