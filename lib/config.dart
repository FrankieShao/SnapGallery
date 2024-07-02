import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static bool isMockData = '1' == dotenv.env['MOCK_DATA'];
}
