import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotiApi {
  static final _noti = FlutterLocalNotificationsPlugin();
  static final onNoti = BehaviorSubject<String?>();

  static Future _notiDetail() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "1",
          "Tutor Helper",
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initSchedule = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const ios = IOSInitializationSettings();
    const setting = InitializationSettings(android: android, iOS: ios);

    await _noti.initialize(setting, onSelectNotification: (payload) async {
      onNoti.add(payload);
    });
  }

  static Future showNoti({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      _noti.show(id, title, body, await _notiDetail());

  static Future showScheduleNoti({
    int id = 0,
    String? title,
    String? body,
    required DateTime scheduleDate,
  }) async =>
      _noti.zonedSchedule(id, title, body,
          tz.TZDateTime.from(scheduleDate, tz.local), await _notiDetail(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
}
