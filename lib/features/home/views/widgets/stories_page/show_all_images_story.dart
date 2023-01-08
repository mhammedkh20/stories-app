import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';

class ShowAllImagesStoryWidget extends StatefulWidget {
  final Story story;

  ShowAllImagesStoryWidget({required this.story});

  @override
  State<ShowAllImagesStoryWidget> createState() =>
      _ShowAllImagesStoryWidgetState();
}

class _ShowAllImagesStoryWidgetState extends State<ShowAllImagesStoryWidget> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    StoryCubit.get(context).onChangePageView(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430.h,
      // child: PageTurn(
      //   key: _controller,
      //   backgroundColor: Colors.white,
      //   showDragCutoff: false,
      //   lastPage: Center(
      //       child: MyText(
      //     title: 'آخر صفحة!',
      //   )),
      //   children: [
      //     for (var i = 0; i < story.otherImages!.length; i++)
      // Container(
      //     color: AppColors.WHITE,
      //     child: CachedNetworkImage(
      //       imageUrl: story.otherImages![i],
      //       imageBuilder: (context, imageProvider) => Container(
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: imageProvider,
      //           ),
      //         ),
      //       ),
      //       placeholder: (context, url) =>
      //           const Center(child: CircularProgressIndicator.adaptive()),
      //       errorWidget: (context, url, error) => const Icon(Icons.error),
      //     )),
      //   ],
      // ),

      child: Stack(
        children: [
          PositionedDirectional(
            start: 20.w,
            end: 20.w,
            top: 0,
            bottom: 0,
            child: PageView.builder(
                controller: _pageController,
                itemCount: widget.story.otherImages!.length,
                onPageChanged: (int page) {
                  StoryCubit.get(context).onChangePageView(page);
                },
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    color: AppColors.WHITE,
                    child: CachedNetworkImage(
                      imageUrl: widget.story.otherImages![i],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                }),
          ),
          BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              return PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                child: Center(
                    child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: StoryCubit.get(context).indexPageViewImages == 0
                      ? null
                      : () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                )),
              );
            },
          ),
          BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              return PositionedDirectional(
                end: 0,
                top: 0,
                bottom: 0,
                child: Center(
                    child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: StoryCubit.get(context).indexPageViewImages ==
                          (widget.story.otherImages!.length - 1)
                      ? null
                      : () {
                          _pageController.animateToPage(
                            StoryCubit.get(context).indexPageViewImages + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                )),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<StoryCubit, StoryState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listIndecator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listIndecator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.story.otherImages!.length; i++) {
      list.add(
        Container(
          height: 10.r,
          width: 10.r,
          decoration: BoxDecoration(
              color: i == StoryCubit.get(context).indexPageViewImages
                  ? AppColors.BASE_COLOR
                  : AppColors.WHITE,
              border: i == StoryCubit.get(context).indexPageViewImages
                  ? null
                  : Border.all(
                      color: AppColors.GRAY,
                    ),
              shape: BoxShape.circle),
        ),
      );
      list.add(SizedBox(width: 5.w));
    }
    return list;
  }
}
