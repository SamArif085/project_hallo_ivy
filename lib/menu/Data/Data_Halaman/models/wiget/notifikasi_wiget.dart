import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../notifikasi.dart';
import '../page/page.dart';

class LocalNotificationWidget extends StatefulWidget {
  const LocalNotificationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();
  late final String payload;
  void onSelectNotification(NotificationResponse payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondPage(payload: payload.toString())),
    );
  }

  @override
  void initState() {
    super.initState();

    const settingsAndroid = AndroidInitializationSettings('app_icon');

    notifications.initialize(
      const InitializationSettings(android: settingsAndroid),
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            title('Basics'),
            ElevatedButton(
              child: const Text('Show notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'Tite', body: 'Body'),
            ),
            ElevatedButton(
              child: const Text('Replace notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'ReplacedTitle', body: 'ReplacedBody'),
            ),
            ElevatedButton(
              child: const Text('Other notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'OtherTitle', body: 'OtherBody', id: 20),
            ),
            const SizedBox(height: 32),
            title('Feautures'),
            ElevatedButton(
              child: const Text('Silent notification'),
              onPressed: () => showSilentNotification(notifications,
                  title: 'SilentTitle', body: 'SilentBody', id: 30),
            ),
            const SizedBox(height: 32),
            title('Cancel'),
            ElevatedButton(
              onPressed: notifications.cancelAll,
              child: const Text('Cancel all notification'),
            ),
          ],
        ),
      );

  Widget title(String text) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      );
}
