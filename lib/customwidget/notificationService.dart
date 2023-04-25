import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fts/splash/splashServices.dart';

class NotificationWidget {
  static Future init({bool scheduled = false}) async {
    var initAndroidSettings = AndroidInitializationSettings("logo");
    final settings = InitializationSettings(android: initAndroidSettings);
    await _notification.initialize(settings);
  }

  static final _notification = FlutterLocalNotificationsPlugin();

  static Future showNotification(
          {var id = 0, var title, var body, var payload}) async =>
      _notification.show(id, title, body, await notificationDetails());

  static Future showNotificationOnFirebase(
          {var id = 0, var title, var body, var payload}) async =>
      _notification.show(id, title, body, await notificationDetails());

  static notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
      'channel id 1',
      'channel name',
      importance: Importance.max,
    ));
  }
}
