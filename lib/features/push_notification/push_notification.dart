import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:html' as html;

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    NotificationSettings settings =
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Permission : ${settings.authorizationStatus}");

    String? token = await _messaging.getToken(
      vapidKey: "BN8wrxkhWY0Yx7Y3lxfXI2ZrNboAbgiMf4i3rba1xgSdN4usZFzVqnfuv7M6SuaA4zvy73-lBi7J31JZWdCC5fc",
    );

    print("FCM Token:");
    print(token);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Foreground Notification");
    //
    //   print(message.notification?.title);
    //   print(message.notification?.body);
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification");

      final title = message.notification?.title ?? "Notification";
      final body = message.notification?.body ?? "";
      print(html.Notification.permission);



      if (html.Notification.permission == "granted") {
        html.Notification(
          title,
          body: body,
          icon: "/icons/Icon-192.png",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification Clicked");
    });
  }
}