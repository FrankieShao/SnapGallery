import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuildConfig {
  static String baseUrl = dotenv.env['BASE_URI']!;
  static String secretKey = dotenv.env['SECRET_KEY']!;
  static String accessKey = dotenv.env['ACCESS_KEY']!;
  static String redirectUri = dotenv.env['REDIRECT_URI']!;
  static bool isMockData = '1' == dotenv.env['MOCK_DATA']!;
  static bool showNetworkLogs = '1' == dotenv.env['SHOW_NETWORK_LOGS']!;
}
