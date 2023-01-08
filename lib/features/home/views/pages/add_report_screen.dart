import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/core/widgets/my_textfield.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/must_be_required.dart';

class AddReportScreen extends StatelessWidget {
  final String? docId;
  final String usernameStory;
  final String titleStory;

  final TextEditingController _textReportController = TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  AddReportScreen({
    this.docId,
    required this.titleStory,
    required this.usernameStory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            MyText(title: 'ابلاغ عن مستخدم او محتوى', color: AppColors.WHITE),
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
                const MustBeRequired('نوع الابلاغ'),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: BlocBuilder<ShareFriendsCubit, ShareFriendsState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: ShareFriendsCubit.get(context).typeReport,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: ShareFriendsCubit.get(context)
                            .listTypeReport
                            .map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: MyText(
                              title: items,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          ShareFriendsCubit.get(context)
                              .changeTypeReport(newValue!);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                const MustBeRequired('نوع التفاصيل'),
                MyTextField(
                  hint: 'ادخل تفاصيل التقرير',
                  iconData: Icons.description,
                  controller: _textReportController,
                  maxLines: 8,
                  minLines: 5,
                  validator: docId == null
                      ? null
                      : (value) {
                          if (value!.isEmpty) {
                            return 'ادخل تفاصيل التقرير';
                          }
                          return null;
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
                      onPressed: docId == null
                          ? null
                          : () async {
                              if (_keyForm.currentState!.validate()) {
                                String type =
                                    ShareFriendsCubit.get(context).typeReport ==
                                            "ابلاغ عن المحتوى"
                                        ? 'content'
                                        : 'user';
                                bool uploaded =
                                    await ShareFriendsCubit.get(context)
                                        .createReport(
                                  context,
                                  reportUserOrContent: type,
                                  details: _textReportController.text.trim(),
                                  docId: docId!,
                                  titleStory: titleStory,
                                  username: usernameStory,
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
