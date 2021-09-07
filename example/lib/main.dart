import 'dart:async';
import 'dart:io';

import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('TERI TERI'),
              Text('Audio'),
              ElevatedButton(
                onPressed: () async {
                  options = DownloaderUtils(
                      progressCallback: (current, total) {
                        final progress = (current / total) * 100;
                        print('Downloading: $progress');
                      },
                      file: File('$path/200MB.zip'),
                      progress: ProgressImplementation(),
                      onDone: () => print('COMPLETE'),
                      deleteOnCancel: true,
                      showNotification: true,
                      notificationUtils: NotificationUtils(
                          androidNotificationIcon: 'ic_launcher',
                          title: 'File Downloading',
                          body: 'Downloading...'));
                  core = await Flowder.download(
                      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                      options);
                },
                child: Text('DOWNLOAD'),
              ),
              ElevatedButton(
                onPressed: () async => core.resume(),
                child: Text('RESUME'),
              ),
              ElevatedButton(
                onPressed: () async => core.cancel(),
                child: Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () async => core.pause(),
                child: Text('PAUSE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
