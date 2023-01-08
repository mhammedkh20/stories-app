import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/features/home/views/manager/add_photo/add_photo_cubit.dart';

class ItemAddImage extends StatelessWidget {
  final bool rectangleShape;
  const ItemAddImage({this.rectangleShape = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.GRAY_LIGHT.withOpacity(.1),
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () async {
          final ImagePicker _picker = ImagePicker();
          XFile? image = await _picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            AddPhotoCubit.get(context).addPhoto(image);
          }
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: rectangleShape ? 150.r : 130.r,
          width: rectangleShape ? double.infinity : 130.r,
          decoration: BoxDecoration(
              shape: rectangleShape ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: rectangleShape ? BorderRadius.circular(20) : null),
          child: Stack(
            children: [
              BlocBuilder<AddPhotoCubit, AddPhotoState>(
                builder: (context, state) {
                  if (AddPhotoCubit.get(context).image == null) {
                    return const SizedBox();
                  }
                  return Image.file(
                    AddPhotoCubit.get(context).image!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 40.r,
                  color: AppColors.BASE_COLOR.withOpacity(.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
