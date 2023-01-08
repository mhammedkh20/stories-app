import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webviewx/webviewx.dart';

class MyItemIFrame extends StatelessWidget {
  late WebViewXController webviewController;

  final String title;
  final String? url;
  final double width;

  MyItemIFrame({
    required this.title,
    required this.url,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      height: 300,
      width: double.infinity,
      initialContent:
          "<iframe width=\"${width}\" height=\"300\" src=\"${url}\" title=\"${title}\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>",
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
    );
  }
}
