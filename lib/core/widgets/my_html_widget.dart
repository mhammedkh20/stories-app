import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stories_app/features/home/views/manager/contact_cubit/contect_cubit.dart';

class MyHTMLWidget extends StatelessWidget {
  final String text;
  const MyHTMLWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      text,
      isSelectable: true,
      onErrorBuilder: (context, element, error) =>
          Text('$element error: $error'),
      onLoadingBuilder: (context, element, loadingProgress) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      textStyle: TextStyle(fontSize: 14.sp),
    );
  }
}
