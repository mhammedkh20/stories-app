import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stories_app/core/utils/helpers.dart';

//  android and ios
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
  );

  static void requestIOSPermissions() {
    if (Platform.isIOS) {
      _notification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static const InboxStyleInformation _inboxStyleInformation =
      InboxStyleInformation(
    ['mohammed', 'khaled', 'alseqaly'], //listMessages
    contentTitle: '3 messages', //dynamic
    summaryText: 'janedoe@example.com', // gmail
  );

  static Future _notificationDetails({String? urlImage}) async {
    String largeIconPath = await Helpers.downloadFile(
        'https://thumbs.dreamstime.com/z/vue-a%C3%A9rienne-de-lago-antorno-dolomites-paysage-montagne-lac-103752677.jpg',
        'lageIconPath');

    String? bigPicturePath;
    if (urlImage != null) {
      bigPicturePath = await Helpers.downloadFile(urlImage, 'lageIconPath');
    }

    StyleInformation? styleInformation;
    if (urlImage != null) {
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath!),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
      );
    }
    // String sound = 'sound_notification.wav'; // add sound to notificaiton
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        // styleInformation: _inboxStyleInformation,
        styleInformation: styleInformation,
        enableVibration: false,
        // sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      ),
      iOS: IOSNotificationDetails(
          // sound: sound,
          ),
    );
  }

  Future initNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions();
  }

  static Future init() async {
    log('my token Device${await FirebaseMessaging.instance.getToken()}');
    NotificationAppLaunchDetails? details =
        await _notification.getNotificationAppLaunchDetails();

    // when app is closed
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.payload);
    }

    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings ios = const IOSInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    _notification.initialize(settings, onSelectNotification: (String? paylod) {
      onNotification.add(paylod);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? urlImage,
  }) async {
    _notification.show(
      id,
      title,
      body,
      await _notificationDetails(urlImage: urlImage),
      payload: payload,
    );
  }

  Future cancelNotificationById(int id) async {
    await _notification.cancel(id);
  }

  Future cancelAllNotification() async {
    await _notification.cancelAll();
  }
}
