import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stories_app/core/utils/my_admob_ad_google.dart';
import 'package:stories_app/core/widgets/my_html_widget.dart';
import 'package:stories_app/features/home/views/manager/contact_cubit/contect_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // BannerAd? _bannerAd;

  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  _createBannerAd() {
    // _bannerAd = BannerAd(
    //   size: AdSize.fullBanner,
    //   adUnitId: MyAdmobAds.getBannerAdUnitId()!,
    //   listener: MyAdmobAds.bannerAdListener,
    //   request: const AdRequest(),
    // )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // _bannerAd == null
              //     ? const SizedBox()
              //     : SizedBox(
              //         height: 60.h,
              //         width: double.infinity,
              //         child: AdWidget(
              //           ad: _bannerAd!,
              //         ),
              //       ),
              const FacebookBannerAdWidget(),

              // _bannerAd == null ? const SizedBox() : SizedBox(height: 10.h),
              SizedBox(height: 10.h),
              BlocBuilder<ContactCubit, ContectState>(
                builder: (context, state) {
                  if (ContactCubit.get(context).loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  return MyHTMLWidget(
                    text: ContactCubit.get(context).htmlPage,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
