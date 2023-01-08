import 'dart:io';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/helpers.dart';

class FacebookNativeAdWidget extends StatelessWidget {
  const FacebookNativeAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Helpers.showNativeAds = false;
    return SizedBox(
      child: Stack(
        children: [
          FacebookNativeAd(
            // placementId:
            //     "VID_HD_16_9_46S_APP_INSTALL#2312433698835503_2964952163583650",
            placementId: Platform.isAndroid
                ? "674535984211948_674536814211865"
                : "674535984211948_675680867430793",
            adType: NativeAdType.NATIVE_AD,
            width: double.infinity,
            // height: 300.h,
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            descriptionColor: Colors.white,
            buttonColor: Colors.deepPurple,
            buttonTitleColor: Colors.white,
            buttonBorderColor: Colors.white,
            listener: (result, value) {
              print("Native Ad: $result --> $value");
            },
            keepExpandedWhileLoading: false,
            expandAnimationDuraion: 1000,
          ),
        ],
      ),
    );
  }
}
