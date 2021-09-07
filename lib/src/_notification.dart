import 'package:flowder/flowder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DownloadNotification {
  final NotificationUtils notificationUtils;

  DownloadNotification(this.notificationUtils);

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  final AndroidNotificationChannel _channel = AndroidNotificationChannel(
      'high_importance_channel',
      'download',
      'This channel used for download file.',
      importance: Importance.high);

  Future<void> initializationNotification() async {
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
            notificationUtils.androidNotificationIcon);
    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            defaultPresentAlert: true,
            onDidReceiveLocalNotification: (id, title, body, payload) async {
              print('onDidReceiveLocalNotification');
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        print('onSelectNotification');
        print(payload);
      },
    );
    showNotification();
  }

  Future<void> showNotification() async {
    const int maxProgress = 50;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
                _channel.id, _channel.name, _channel.description,
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: true,
                maxProgress: maxProgress,
                progress: i);

        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        _flutterLocalNotificationsPlugin.show(
            notificationUtils.title.hashCode,
            notificationUtils.title,
            notificationUtils.body,
            platformChannelSpecifics,
            payload: '');
      });
    }
  }
}
