
class AppConfig {
  static const fractionFormatter = "#,###";

  static const fractionDigits = 4;

  static const errorMessage = "请求失败，请稍后再试~";

  static const networkErrorMessage = "Bad network.Try again later.";

  static const formattedDateTime = "MM-dd HH:mm";

  static const initialFormatter = 1.0;

  static const textFieldMaxLength = 8;

  static const feedbackImageLength = 3;

  /// - @path 'me'/'feedback'
  static const percentFractionDigits = 0;

  // firebase collection name
  static const feedbackCollectionName = 'feedback';

  static const savedLocaleCodeKey = 'userLocaleCode';

  // default language locale
  static const defaultLocaleCode = 'en';

  static const currentSourceContinentIndex = 0; // Asia
  static const currentSourceCountryInex = 8;   // cn(China)

  static const currentTargetContinentIndex = 0; // Asia
  static const currentTargetCountryIndex = 17; // jp(Japan)

  /// Whether to receive application notification
  /// @used: is_readonly_state_provider.dart
  static const isDefaultNotificationAvailable = false;

  /// The name of notification switch key
  /// @used: custom_notification_setting.dart
  static const kNotificationSwitchKey = 'is_notification_available';

  // The string saved in SharedPreference
  static const savedNotificationKey = 'isShowBadge';
}