import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConf {
  static Future<void> init() async {
    await dotenv.load();
  }

  static String get apiKeyAndroid => dotenv.env['API_KEY_ANDROID'] ?? '';
  static String get apiKeyIos => dotenv.env['API_KEY_IOS'] ?? '';
  static String get appIdAndroid => dotenv.env['APP_ID_ANDROID'] ?? '';
  static String get appIdIos => dotenv.env['APP_ID_IOS'] ?? '';
  static String get messagingSenderId =>
      dotenv.env['MESSAGING_SENDER_ID'] ?? '';
  static String get projectId => dotenv.env['PROJECT_ID'] ?? '';
  static String get storageBucket => dotenv.env['STORAGE_BUCKET'] ?? '';
  static String get iosBundleId => dotenv.env['IOS_BUNDLE_ID'] ?? '';
  static String get simklApiKey => dotenv.env['SIMKL_API_KEY'] ?? '';
}
