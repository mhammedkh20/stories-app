import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/manager/add_photo/add_photo_cubit.dart';

class ItemClickFileWidget extends StatelessWidget {
  final int itemSelected;

  const ItemClickFileWidget({required this.itemSelected});

  @override
  Widget build(BuildContext context) {
    print(itemSelected);
    return InkWell(
      onTap: () async {
        FilePickerResult? result;
        if (itemSelected == 0) {
          result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['mp4'],
          );
        } else {
          result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['mp3'],
          );
        }
        if (result != null) {
          PlatformFile file = result.files.single;
          AddPhotoCubit.get(context).addFile(file);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.GRAY_LIGHT),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload, color: AppColors.GRAY),
            SizedBox(width: 15.w),
            MyText(
              title: 'اختار ملف ${itemSelected == 0 ? 'فيديو' : 'صوت'}',
              fontSize: 14,
              color: AppColors.GRAY,
            ),
          ],
        ),
      ),
    );
  }
}
