import 'dart:io';

import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:flowder/src/flowder.dart';
import 'package:flowder/src/progress/interfaces/progress_interface.dart';
import 'package:flowder/src/utils/notification_utils.dart';

/// Required for the initialization of [Flowder]
class DownloaderUtils {
  /// Notification Progress Channel Interface
  /// Please use [ProgressImplementation] when called
  final ProgressInterface progress;

  /// Dio Client for HTTP Request
  Dio? client;

  /// Setup a location to store the downloaded file
  File file;

  /// should delete when cancel?
  bool deleteOnCancel;

  /// Function to be called when the download has finished.
  final VoidCallback onDone;

  /// Function with the current values of the download
  /// ```dart
  /// Function(int bytes, int total) => print('current byte: $bytes and total of bytes: $total');
  /// ```
  final ProgressCallback progressCallback;

  /// Setup the notification
  /// should show notification while downloading
  /// default value set to true
  final bool showNotification;

  ///Notification utils

  final NotificationUtils notificationUtils;

  DownloaderUtils({
    required this.progress,
    this.client,
    required this.file,
    this.deleteOnCancel = false,
    required this.onDone,
    required this.progressCallback,
    this.showNotification = true,
    required this.notificationUtils,
  });
}
