/// Required for the initialization of [Notification]
class NotificationUtils {
  /// Drawable icon that use in notification icon.
  /// Only for Android
  final String androidNotificationIcon;

  /// Notification title
  /// IOS
  /// Android
  final String title;

  ///Notification body
  ///IOS
  ///Android
  final String body;

  ///Notification payload
  final String? payload;

  const NotificationUtils(
      {required this.androidNotificationIcon,
      required this.title,
      required this.body,
      this.payload});
}
