import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppKeys {
  static final String googleAPIKey = dotenv.env['GOOGLE_MAP_API_KEY'] as String;
}
