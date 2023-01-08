import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stories_app/config.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/storage/pref/shared_pref_controller.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/utils/notification_api.dart';
import 'package:stories_app/features/other/launch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharedPref();
  await DBProvider().initDatabase();
  await NotificationApi().initNotification();

  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helpers.oriantationDecive();

    FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;
    fiam.triggerEvent('some_trigger');

    return ScreenUtilInit(
      designSize: const Size(360, 720),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MultiBlocProvider(
          providers: Config.providers,
          child: MaterialApp(
            title: 'Stories App',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: Config.localizationsDelegates,
            supportedLocales: const [Locale('en'), Locale('ar')],
            locale: const Locale('ar'),
            theme: ThemeData(primarySwatch: AppColors.APP_THEME),
            home: child,
          ),
        );
      },
      child: const LaunchScreen(),
    );
  }
}
