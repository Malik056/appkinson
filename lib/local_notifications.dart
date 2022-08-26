import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static late AndroidNotificationDetails androidSettings;
  static late IOSNotificationDetails iosSettings;

  static void initializer() {
    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails("111", "Solicitud de relación", channelDescription: "Tienes una solicitud de relación", importance: Importance.high, priority: Priority.max);
    var androidInitialization = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialization, iOS: null);
    flutterNotificationPlugin.initialize(initializationSettings, onSelectNotification: onNotificationSelect);
  }

  static Future<void> onNotificationSelect(String? payload) async {
    print(payload);
  }

  static Future<void> showOneTimeNotification(DateTime scheduledDate) async {
    var notificationDetails = NotificationDetails(android: androidSettings, iOS: null);
    // ignore: deprecated_member_use
    await flutterNotificationPlugin.schedule(1, "Solicitud de relación",
        "¡Alguien quiere cuidar de tí!", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}
