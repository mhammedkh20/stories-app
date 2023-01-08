import 'package:stories_app/features/other/export_files.dart';

class StoryScreen extends StatefulWidget {
  final Story story;
  final String? categoryId;
  final int indexCategory;
  final int indexStory;
  final bool okVedio;
  final bool downloadScreen;
  final Story storyDB;
  final String? docId;

  StoryScreen({
    required this.story,
    required this.categoryId,
    required this.indexCategory,
    required this.indexStory,
    required this.storyDB,
    this.docId,
    this.okVedio = false,
    this.downloadScreen = false,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  Database _database = DBProvider().database;

  late WebViewXController webviewController;

  @override
  void initState() {
    // TODO: implement initState
    // Helpers.loadRewardedVideoAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthVedio = MediaQuery.of(context).size.width - 32.w;
    if (widget.docId != null) {
      if (ProgressLoadingCubit.get(context).getLoadingStory(widget.docId) !=
          null) {
        ProgressLoadingCubit.get(context)
            .getLoadingStory(widget.docId)!
            .progress = 0;
      }
    }
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      menuBackgroundColor: AppColors.BASE_COLOR.withOpacity(.8),
      controller: zoomDrawerController,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuScreen: const MyDrawer(clearNavigationRoot: true),
      mainScreen: Scaffold(
        appBar: AppBar(
          title: MyText(title: widget.story.title ?? ''),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                zoomDrawerController.toggle!();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.WHITE,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FacebookBannerAdWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    children: [
                      widget.okVedio
                          ? MyItemIFrame(
                              width: widthVedio,
                              title: widget.story.title ?? "",
                              url: widget.story.okvideo!,
                            )
                          : widget.story.otherImages == null
                              ? (StoryCubit.get(context).selectedItemCategory ==
                                                  0
                                              ? widget.story.url2
                                              : widget.story.url) !=
                                          null &&
                                      (StoryCubit.get(context)
                                                      .selectedItemCategory ==
                                                  0
                                              ? widget.story.url2!
                                              : widget.story.url!)
                                          .isNotEmpty
                                  ? MyItemVedio2Widget(
                                      story: widget.story,
                                      storyDB: widget.okVedio
                                          ? Story()
                                          : widget.storyDB,
                                    )
                                  : MyItemAudioWidget(
                                      story: widget.story,
                                      storyDB: widget.okVedio
                                          ? Story()
                                          : widget.storyDB,
                                    )
                              : widget.story.otherImages!.length == 0
                                  ? MyItemAudioWidget(
                                      story: widget.story,
                                      storyDB: widget.okVedio
                                          ? Story()
                                          : widget.storyDB,
                                    )
                                  : ShowAllImagesStoryWidget(
                                      story: widget.story),
                      SizedBox(height: 10.h),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyElevatedButton(
                              height: 40.h,
                              iconData: Icons.share,
                              title: 'مشاركة',
                              onPressed: () {
                                String? descStory = widget.story.description;
                                if (descStory != null) {
                                  descStory = descStory.replaceAll('<br>', '');
                                  descStory = descStory.replaceAll('<p>', '');
                                }
                                Share.share(
                                    // \n
                                    widget.story.url != null
                                        ? descStory != null
                                            ? 'عنوان القصة: ${widget.story.title}\nوصف القصة: ${descStory}\nملف فيديو : ${widget.story.url} لمزيد من القصص حمل التطبيق  https://play.google.com/store/apps/details?id=com.storyvideo.saleh'
                                            : 'عنوان القصة: ${widget.story.title}\nملف فيديو : ${widget.story.url} لمزيد من القصص حمل التطبيق  https://play.google.com/store/apps/details?id=com.storyvideo.saleh'
                                        : descStory == null
                                            ? 'عنوان القصة: ${widget.story.title}\n لمزيد من القصص حمل التطبيق  https://play.google.com/store/apps/details?id=com.storyvideo.saleh'
                                            : 'عنوان القصة: ${widget.story.title}\nوصف القصة: ${descStory}\nلمزيد من القصص حمل التطبيق  https://play.google.com/store/apps/details?id=com.storyvideo.saleh',
                                    subject:
                                        'شارك تطبيق قصتي وتمتع انت واصدقائك بأجمل القصص');
                              },
                            ),
                          ),
                          SizedBox(width: 20.w),
                          if (!widget.downloadScreen &&
                              widget.story.likes != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BlocBuilder<StoryCubit, StoryState>(
                                  builder: (context, state) {
                                    return MyText(
                                      title: '${widget.story.likes ?? "0"}',
                                      fontSize: 19,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: Stack(
                                    children: [
                                      IconFavoriateWidgetAnimated(
                                        onTap: () {
                                          if (widget.categoryId != null) {
                                            StatusIconFavoriteCubit.get(context)
                                                .changeStatus();
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 200), () {
                                              StatusIconFavoriteCubit.get(
                                                      context)
                                                  .changeStatus();
                                            });

                                            StoryCubit.get(context)
                                                .updateLikeStory(
                                              categoryId: widget.categoryId!,
                                              indexCategory:
                                                  widget.indexCategory,
                                              indexStory: widget.indexStory,
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: MyText(
                          textAlign: TextAlign.start,
                          title: widget.story.title ?? "",
                        ),
                      ),
                      SizedBox(height: 20.h),
                      MyHTMLWidget(text: widget.story.description ?? ''),
                      SizedBox(height: 20.h),
                      const FacebookNativeAdWidget(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                ListStoriesWidget(clearNavigationRoot: true),
                SizedBox(height: 20.h),
                CategoriesWidget2(),
                SizedBox(height: 20.h),
              ],
            ),
          ]),
        ),
        bottomNavigationBar:
            const BottomNavigationMainScreen(navigationBack: true),
      ),
    );
  }
}
