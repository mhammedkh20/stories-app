import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/core/widgets/my_textfield.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/item_add_image.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/item_click_file_widget.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/must_be_required.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/vedio_or_audio_widget.dart';

class AddShareFrindScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _titleStoryController = TextEditingController();
  final TextEditingController _descStoryController = TextEditingController();

  AddShareFrindScreen({Key? key}) : super(key: key);

  var _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(title: 'شارك قصة مع الاصدقاء', color: AppColors.WHITE),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const FacebookBannerAdWidget(),
                SizedBox(height: 30.h),
                const MustBeRequired('الاسم'),
                MyTextField(
                  hint: 'ادخل اسمك',
                  iconData: Icons.person,
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'قم بإدخال اسمك';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                const MustBeRequired('البلد'),
                MyTextField(
                  hint: 'ادخل اسم المدينة',
                  iconData: Icons.location_city,
                  controller: _countryController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'قم بإدخال اسم المدينة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                const MustBeRequired("عنوان القصة"),
                MyTextField(
                  hint: 'ادخل عنوان القصة',
                  iconData: Icons.title,
                  controller: _descStoryController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'قم بإدخال عنوان القصة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                const MustBeRequired("وصف القصة"),
                MyTextField(
                  hint: 'ادخل وصف القصة',
                  iconData: Icons.description,
                  controller: _titleStoryController,
                  maxLines: 5,
                  minLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'قم بإدخال وصف القصة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                const MustBeRequired("اختار صورة للقصة"),
                const ItemAddImage(rectangleShape: true),
                SizedBox(height: 15.h),
                const MustBeRequired("اختار فيديو / صوت", choice: true),
                SizedBox(height: 10.h),
                BlocBuilder<ShareFriendsCubit, ShareFriendsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(children: [
                          VedioOrAudioWidget(
                            title: "فيديو",
                            index: ShareFriendsCubit.get(context).vedioOrAudio,
                            keyVedioOrAudio: 0,
                          ),
                          SizedBox(width: 20.w),
                          VedioOrAudioWidget(
                            title: "صوت",
                            index: ShareFriendsCubit.get(context).vedioOrAudio,
                            keyVedioOrAudio: 1,
                          ),
                        ]),
                        if (ShareFriendsCubit.get(context).vedioOrAudio != -1)
                          Column(
                            children: [
                              SizedBox(height: 15.h),
                              ItemClickFileWidget(
                                itemSelected:
                                    ShareFriendsCubit.get(context).vedioOrAudio,
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30.h),
                BlocBuilder<ShareFriendsCubit, ShareFriendsState>(
                  builder: (context, state) {
                    if (ShareFriendsCubit.get(context).loadingUploadData) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return MyElevatedButton(
                      title: 'شارك',
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          bool uploaded = await ShareFriendsCubit.get(context)
                              .uploadStoryWithFriends(
                            context,
                            name: _nameController.text.trim(),
                            country: _countryController.text.trim(),
                            titleStory: _titleStoryController.text.trim(),
                            descStory: _descStoryController.text.trim(),
                          );
                          if (uploaded) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
