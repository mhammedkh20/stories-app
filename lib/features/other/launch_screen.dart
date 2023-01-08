import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/views/pages/main_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with SingleTickerProviderStateMixin {
  bool enabledAnimation = false;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _animationController.forward();

    Future.delayed(const Duration(microseconds: 2), () {
      setState(() {
        enabledAnimation = true;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      Helpers.navigationReplacementToPage(context, const MainScreen());
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFFOLD_Launch,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * math.pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/images/logo-splash.png',
                    width: 100.w,
                  ),
                ),
              ),
            ),
            AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 1800),
              bottom: enabledAnimation ? 0 : -150.h,
              start: 0,
              child: Image.asset(
                'assets/images/ic_animals.png',
                height: 150.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
