import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluetrack/core/components/auth_custom_button.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';
import 'package:bluetrack/view/auth/login_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'dart:ui' as ui;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = 'onboarding_route';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isShowSignInDialog = false;
  double _bottomCardHeight = 0.55; // نسبة الارتفاع الافتراضية
  double _backgroundOpacity = 1.0; // الشفافية الافتراضية للخلفية
  final ValueNotifier<bool> _showLoginScreen = ValueNotifier<bool>(
    false,
  ); // التحكم في عرض واجهة تسجيل الدخول

  @override
  void dispose() {
    _showLoginScreen.dispose(); // تأكد من التخلص من ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: context.phoneWidth(),
          height: context.phoneHeight(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildBackgroundImage(context),
              _buildBottomCardOrLogin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned(
      top: 0,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450), // مدة الأنيميشن
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation, // تأثير التلاشي
            child: child,
          );
        },
        child:
            _backgroundOpacity == 1.0
                ? SizedBox(
                  key: const ValueKey('background'), // مفتاح فريد للخلفية
                  height: 500.h,
                  width: context.phoneWidth(),
                  child: Transform.translate(
                    offset: Offset(0, -40.h),
                    child: Image.asset(
                      ImageConstant.instance.onboarding1,
                      height: context.phoneHeight(),
                      width: context.phoneWidth(),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                : Container(
                  key: const ValueKey('logo'), // مفتاح فريد للشعار
                  alignment: Alignment.center,
                  height: 170.h,
                  width: context.phoneWidth(),
                  color: context.background,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpaceConstant.instance.heightXXXLarge,
                      Image.asset(
                        ImageConstant.instance.newLogo,
                        height: 50.h,
                        width: context.phoneHeight(),
                      ),
                      SpaceConstant.instance.heightXSmall,
                      Expanded(
                        flex: 10,
                        child: Txt(
                          text: 'bluetrack',
                          fontSize: 16.sp,
                          color: context.inverse.withOpacity(.8),
                          fontWeight: FontWeight.w600,
                          family: FontFamilyEnum.enSora.rawValue,
                          letterSpacing: .6,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  // دالة لبناء BottomCard أو LoginScreen بناءً على ValueNotifier
  Widget _buildBottomCardOrLogin(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showLoginScreen,
      builder: (context, showLogin, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height:
              context.phoneHeight() * _bottomCardHeight, // التحكم في الارتفاع
          width: context.phoneWidth(),
          decoration: BoxDecoration(
            color: context.onBackground,
            border: Border(
              top: BorderSide(
                color: ColorConstants.instance.primary.withOpacity(.5),
                width: 2.r,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              // BottomCard (shown when showLogin is false)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                opacity: !showLogin ? 1 : 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    _buildHeaderText(),
                    SpaceConstant.instance.heightSmall,
                    _buildDescriptionText(context),
                    const Spacer(flex: 7),
                    _buildGetStartedButton(context),
                    _buildSignInTextButton(context),
                    SpaceConstant.instance.heightXSmall,
                  ],
                ),
              ),

              // LoginScreen (shown when showLogin is true)
              Visibility(
                maintainAnimation: true,
                maintainState: true,
                visible: showLogin,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  opacity: showLogin ? 1 : 0,
                  child: const LoginScreen(key: ValueKey('login')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة لبناء BottomCard
  Widget _buildBottomCard(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      height: context.phoneHeight() * _bottomCardHeight, // التحكم في الارتفاع
      width: context.phoneWidth(),
      decoration: BoxDecoration(
        color: context.onBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          _buildHeaderText(),
          SpaceConstant.instance.heightMedium,
          _buildDescriptionText(context),
          const Spacer(flex: 7),
          _buildGetStartedButton(context),
          _buildSignInTextButton(context),
          // const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Txt(
        text: 'Welcome to the BlueTrack app',
        maxLines: 2,
        textAlign: TextAlign.center,
        family: FontFamilyEnum.enSora.rawValue,
        letterSpacing: .4,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Txt(
        text:
            'Track your movements within your surroundings and get the best results with detailed daily analytics that help you understand and improve your activity patterns.',
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.center,
        family: FontFamilyEnum.enInter.rawValue,
        color: context.inverse.withOpacity(.7),
        fontSize: 14.sp,
        letterSpacing: .3,
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: AuthCustomButton(
        onTap: () async {
          // عند الضغط، قم بزيادة الارتفاع وتقليل شفافية الخلفية
          setState(() {
            _bottomCardHeight = 1;
            _backgroundOpacity = 0.0; // تغيير الشفافية للخلفية
          });

          // انتظر حتى تنتهي الأنيميشن
          await Future.delayed(const Duration(milliseconds: 359));

          await SPManager.instance.setOnboardingPage();

          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 200),
              type: PageTransitionType.fade,
              child: const LoginScreen(),
            ),
          );

          // تبديل إلى واجهة تسجيل الدخول
          _showLoginScreen.value = true;
        },
        text: 'Start Now',
      ),
    );
  }

  Widget _buildSignInTextButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // عند الضغط، قم بزيادة الارتفاع وتقليل شفافية الخلفية
        setState(() {
          _bottomCardHeight = 1;
          _backgroundOpacity = 0.0; // تغيير الشفافية للخلفية
        });

        // انتظر حتى تنتهي الأنيميشن
        await Future.delayed(const Duration(milliseconds: 359));

        await SPManager.instance.setOnboardingPage();

        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 200),
            type: PageTransitionType.fade,
            child: const LoginScreen(),
          ),
        );

        // تبديل إلى واجهة تسجيل الدخول
        _showLoginScreen.value = true;
      },
      child: SizedBox(
        width: context.phoneWidth() * .7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              text: 'Do you have an account? ',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: context.inverse.withOpacity(.7),
              family: FontFamilyEnum.enInter.rawValue,
            ),
            // SpaceConstant.instance.widthXXSmall,
            Txt(
              text: 'Log in',
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              color: ColorConstants.instance.primary,
              family: FontFamilyEnum.enInter.rawValue,
              familyAr: FontFamilyEnum.ar.rawValue,
            ),
          ],
        ),
      ),
    );
  }
}
