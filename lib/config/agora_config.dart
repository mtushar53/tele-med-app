import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgoraConfig {
  /// Agora App ID
  static String get appId => dotenv.env['AGORA_APP_ID'] ?? '';

  /// Agora Token
  /// This is a temporary token for testing purposes
  static String get token => dotenv.env['AGORA_TOKEN'] ?? '';

  /// Default channel name for testing
  static String get defaultChannelName =>
      dotenv.env['AGORA_DEFAULT_CHANNEL_NAME'] ?? '';
}
