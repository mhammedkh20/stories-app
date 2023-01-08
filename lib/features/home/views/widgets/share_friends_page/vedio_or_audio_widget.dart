import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';

class VedioOrAudioWidget extends StatelessWidget {
  final String title;
  final int index;
  final int keyVedioOrAudio;

  const VedioOrAudioWidget({
    required this.title,
    required this.index,
    required this.keyVedioOrAudio,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 45.h,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.BLACK.withOpacity(.16),
                blurRadius: 4,
              ),
            ],
            border: Border.all(
              color:
                  ShareFriendsCubit.get(context).vedioOrAudio == keyVedioOrAudio
                      ? AppColors.BASE_COLOR
                      : AppColors.TRANSPARENT,
            )),
        child: Material(
          color: AppColors.WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              ShareFriendsCubit.get(context)
                  .selectedVedioOrAudio(keyVedioOrAudio);
            },
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: MyText(
                      title: title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
