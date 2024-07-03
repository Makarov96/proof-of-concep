import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/core_config/network/just_network_options.dart';

final justNetworkProvider = Provider<JustNetwork>(
  (ref) => JustNetworkOptions(),
);
