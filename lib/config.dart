import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:stories_app/features/home/views/manager/add_photo/add_photo_cubit.dart';
import 'package:stories_app/features/home/views/manager/contact_cubit/contect_cubit.dart';
import 'package:stories_app/features/home/views/manager/download_audio/download_audio_cubit.dart';
import 'package:stories_app/features/home/views/manager/main_cubit/main_cubit.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/pixels_scroll_controller/pixels_scroll_controller_cubit.dart';
import 'package:stories_app/features/home/views/manager/progress_loading/progress_loading_cubit.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_icon_favorite/status_icon_favorite_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_load_vedio_cubit/status_load_vedio_cubit.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stories_app/features/home/views/pages/nav/download_audio.dart';

class Config {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider(create: (context) => MainCubit()),
    BlocProvider(create: (context) => StoryCubit()),
    BlocProvider(create: (context) => ShareFriendsCubit()),
    BlocProvider(create: (context) => PhotoFriendsCubit()),
    BlocProvider(create: (context) => ContactCubit()),
    BlocProvider(create: (context) => PixelsScrollControllerCubit()),
    BlocProvider(create: (context) => StatusLoadVedioCubit()),
    BlocProvider(create: (context) => StatusIconFavoriteCubit()),
    BlocProvider(create: (context) => ProgressLoadingCubit()),
    BlocProvider(create: (context) => AddPhotoCubit()),
    BlocProvider(create: (context) => DownloadAudioCubit()),
  ];

  static Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates =
      const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
