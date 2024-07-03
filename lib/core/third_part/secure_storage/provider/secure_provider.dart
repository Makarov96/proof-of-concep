import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:just_in_play_proof/core/third_part/secure_storage/just_play_secure_storage.dart';

final _flutterSecureStorage = Provider((ref) => const FlutterSecureStorage());

final justPlaySecureProvider = Provider<JustPlaySecureStore>(
    (ref) => JPSecureStore(storage: ref.read(_flutterSecureStorage)));
