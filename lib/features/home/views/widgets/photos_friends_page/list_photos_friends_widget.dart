import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_icon_favorite/status_icon_favorite_cubit.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_story_widget.dart';

class ListPhotosFriendsWidget extends StatelessWidget {
  final List<PhotoFriendsModel> data;
  const ListPhotosFriendsWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 5.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemStoryWidget(
          name: data[index].name,
          urlImage: data[index].file,
          forPhoto: true,
          likes: data[index].likes ?? 0,
          onTap: () {
            if (data[index].docId != null) {
              PhotoFriendsCubit.get(context).updateLikePhoto(index);
            }
          },
          onTapIconFavorite: () {
            if (data[index].docId != null) {
              PhotoFriendsCubit.get(context).updateLikePhoto(index);
            }
          },
        );
      },
    );
  }
}
