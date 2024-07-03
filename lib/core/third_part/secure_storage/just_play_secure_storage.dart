import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JPSecureStore extends JustPlaySecureStore {
  final FlutterSecureStorage storage;

  JPSecureStore({required this.storage});

  @override
  Future<void> write({
    required JustPlaySecureStorageKeys jpKeys,
    String? value,
  }) async =>
      await storage.write(key: jpKeys.key, value: value);

  @override
  Future<String> read({
    required JustPlaySecureStorageKeys jpKeys,
  }) async =>
      (await storage.read(key: jpKeys.key)) ?? '';

  @override
  Future<bool> existValue({
    required JustPlaySecureStorageKeys jpKeys,
  }) async =>
      (await storage.containsKey(key: jpKeys.key));

  @override
  Future<void> deleteAll() async => (await storage.deleteAll());
}

abstract class JustPlaySecureStore {
  Future<bool> existValue({
    required JustPlaySecureStorageKeys jpKeys,
  });

  Future<void> deleteAll();

  Future<void> write({
    required JustPlaySecureStorageKeys jpKeys,
    String? value,
  });

  Future<String> read({
    required JustPlaySecureStorageKeys jpKeys,
  });
}

enum JustPlaySecureStorageKeys {
  userId(key: 'userId');

  const JustPlaySecureStorageKeys({required this.key});
  final String key;
}
