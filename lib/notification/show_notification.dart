import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    show RemoteMessage, RemoteNotification;

class ShowNotification {
  // RemoteNotification? notification;

  // ShowNotification(RemoteMessage message){
  // notification = message.notification;
  // }

  static showMessage(RemoteMessage message) async {
    RemoteNotification notification = message.notification!;
    var content = NotificationContent(
      id: notification.hashCode,
      channelKey: 'basic_channel',
      title: notification.title,
      body: notification.body,
      notificationLayout: NotificationLayout.Default,
    );

    // Schedule the notification to be displayed
    // await AwesomeNotifications().createNotification(content);
    await AwesomeNotifications().createNotification(content: content);
  }
}
