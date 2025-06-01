// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/hex_color.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/local_constant.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/view/start/app_background_animation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';
import 'package:bluetrack/view/auth/login_screen.dart';
import 'package:bluetrack/view/layout/bottom_nav_screen.dart';
import 'package:bluetrack/view/start/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LayoutController layoutController;

  @override
  void initState() {
    super.initState();
    layoutController = Provider.of(context, listen: false);
  }

  Future<bool> controlToApp() async {
    // await SyncTask().syncTask(context, tokenState: tokenState);

    String routeName =
        SPManager.instance.showOnboardingPage() == true
            ? SPManager.instance.getSkipLoginStatus() == true
                ? BottomNavScreen.routeName
                : LoginScreen.routeName
            : OnboardingScreen.routeName;

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controlToApp(),
      builder: (context, snapshot) {
        return mainSplashView();
      },
    );
  }

  mainSplashView() {
    return Scaffold(
      backgroundColor: context.background,
      body: Stack(
        children: [
          const APPBakgroundAnimation(),
          _buildCenterText(),
          Shimmer.fromColors(
            baseColor: Colors.transparent,
            highlightColor: Colors.white38,
            child: _buildCenterText(),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstant.instance.newLogo,
          height: 60.h,
          width: context.phoneHeight(),
          color: ColorConstants.instance.primary,
        ),
        SpaceConstant.instance.heightSmall,
        Txt(
          text: 'ActiView',
          fontSize: 20.sp,
          color: context.inverse.withOpacity(.8),
          fontWeight: FontWeight.w600,
          family: FontFamilyEnum.enSora.rawValue,
          letterSpacing: .6,
        ),
        SpaceConstant.instance.heightXSmall,
        Padding(
          padding: PaddingAndMarginConstant.instance.symmetricHorizontalSmall,
          child: Txt(
            text: 'Master the art of visitors movement with ActiView',
            fontSize: 12.sp,
            color: context.inverse.withOpacity(.8),
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            family: FontFamilyEnum.enSora.rawValue,
            letterSpacing: .6,
          ),
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
          letterSpacing: 4.4,
        ), // The color here is ignored due to the ShaderMask
      ),
    );
  }
}
