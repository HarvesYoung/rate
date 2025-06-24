
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleAdmobConfig {
  static final appId = dotenv.env['GOOGLE_ADMOB_APP_ID'];
}