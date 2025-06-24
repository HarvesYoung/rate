

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExchangeratesConfig {

  static const baseUrl = 'https://api.exchangeratesapi.io/v1';

  static final apiAccessKey = dotenv.env['EXCHANGERATE_API_ACCESS_KEY'];
}