import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String baseUrl = 'https://api.jikan.moe/v4';
}
