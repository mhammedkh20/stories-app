import 'dart:io';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';

class FacebookBannerAdWidget extends StatelessWidget {
  const FacebookBannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FacebookNativeAd(
        // placementId:
        //     "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        placementId: Platform.isAndroid
            ? "674535984211948_674537840878429"
            : '674535984211948_675679957430884',

        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
        adType: NativeAdType.NATIVE_BANNER_AD,
        keepExpandedWhileLoading: false,
        expandAnimationDuraion: 1000,
      ),
    );
  }
}
