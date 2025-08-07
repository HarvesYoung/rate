
class AppConfig {
  static const fractionFormatter = "#,###";

  static const fractionDigits = 4;

  static const errorMessage = "请求失败，请稍后再试~";

  static const networkErrorMessage = "Bad network.Try again later.";

  static const formattedDateTime = "MM-dd HH:mm";

  static const initialFormatter = 1.0;

  static const textFieldMaxLength = 8;

  static const feedbackImageLength = 3;

  /// - @path '我'/'反馈'
  static const percentFractionDigits = 0;

  // firebase collection name
  static const feedbackCollectionName = 'feedback';

  static const currentSourceContinentIndex = 0; // Asia
  static const currentSourceCountryInex = 8;   // cn(China)

  static const currentTargetContinentIndex = 0; // Asia
  static const currentTargetCountryIndex = 17; // jp(Japan)

  /// 是否初始接收app推送
  /// @used: is_readonly_state_provider.dart
  static const isDefaultNotificationAvailable = false;

  /// 是否允许接收推送的flag 名称
  /// @used: custom_notification_setting.dart
  static const kNotificationSwitchKey = 'is_notification_available';
}