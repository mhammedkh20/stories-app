import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/core/widgets/my_textfield.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/item_add_image.dart';

class AddPhotoFrindScreen extends StatelessWidget {
  final String? docId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  AddPhotoFrindScreen({this.docId});

  var _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(title: 'شارك الاصدقاء', color: AppColors.WHITE),
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
                SizedBox(height: 50.h),
                const ItemAddImage(),
                SizedBox(height: 30.h),
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
                SizedBox(height: 70.h),
                BlocBuilder<PhotoFriendsCubit, PhotoFriendsState>(
                  builder: (context, state) {
                    if (PhotoFriendsCubit.get(context).loadingUploadImage) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return MyElevatedButton(
                      title: 'شارك',
                      onPressed: docId == null
                          ? null
                          : () async {
                              if (_keyForm.currentState!.validate()) {
                                bool upload =
                                    await PhotoFriendsCubit.get(context)
                                        .createPhoto(context,
                                            name: _nameController.text.trim(),
                                            country:
                                                _countryController.text.trim());
                                if (upload) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
