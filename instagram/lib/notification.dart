import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

initNotifications() async {
  var androidSetting = AndroidInitializationSettings('app_icon');

  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);

  await notifications.initialize(initializationSettings);

  await notifications.initialize(initializationSettings);
}
