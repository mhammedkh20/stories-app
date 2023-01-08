import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stories_app/features/home/views/manager/main_cubit/main_cubit.dart';
import 'package:stories_app/features/home/views/manager/pixels_scroll_controller/pixels_scroll_controller_cubit.dart';

class BottomNavigationMainScreen extends StatelessWidget {
  final bool navigationBack;

  const BottomNavigationMainScreen({Key? key, this.navigationBack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          elevation: 3,
          backgroundColor: AppColors.BASE_COLOR,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.WHITE,
          unselectedItemColor: AppColors.GRAY_LIGHT,
          currentIndex: MainCubit.get(context).index,
          onTap: (int index) {
            PixelsScrollControllerCubit.get(context).fillAppBar();
            if (navigationBack) Navigator.pop(context);
            MainCubit.get(context).changeIndexBottomNav(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.auto_stories),
              label: AppLocalizations.of(context)!.stories,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.share),
              label: AppLocalizations.of(context)!.shareFriends,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.photo),
              label: AppLocalizations.of(context)!.photosFriends,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.download),
              label: AppLocalizations.of(context)!.download,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.contact_support),
              label: AppLocalizations.of(context)!.contactWithUs,
            )
          ],
        );
      },
    );
  }
}
