import 'dart:io';

import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/view/start/app_background_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/animation_list_view_card.dart';
import 'package:bluetrack/core/components/auth_custom_button.dart';
import 'package:bluetrack/core/components/custom_animation_visibility.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';
import 'package:bluetrack/view/auth/components/auth_text_faild.dart';
import 'package:bluetrack/view/auth/signup_screen.dart';
import 'package:bluetrack/view/layout/bottom_nav_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({this.isOpenKeyboard = true, super.key});

  final bool isOpenKeyboard;
  static const String routeName = 'login_route';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late ValueNotifier<bool> showPasswordText;
  late final FocusNode userNameFocusNode;
  late bool signUpByEmail = true;

  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    showPasswordText = ValueNotifier(true);
    passwordFocusNode = FocusNode();
    userNameFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpaceConstant.instance.heightXXXLarge,
                SpaceConstant.instance.heightXXXLarge,
                AnimationListViewCard(
                  index: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.instance.newLogo,
                        height: 50.h,
                        color: ColorConstants.instance.primary,
                      ),
                      SpaceConstant.instance.heightSmall,
                      _buildHeaderText(),
                      SpaceConstant.instance.heightXXSmall,
                      _buildDescriptionText(),
                    ],
                  ),
                ),
                SpaceConstant.instance.heightLarge,
                AnimationListViewCard(
                  index: 1,
                  child: Visibility(
                    visible: signUpByEmail,
                    replacement: _buildUserNameField(),
                    child: _buildUserNameField(),
                  ),
                ),
                // AnimationListViewCard(index: 1, child: _buildUserNameField()),
                SpaceConstant.instance.heightMedium,
                AnimationListViewCard(index: 1, child: _buildPasswordField()),
                SpaceConstant.instance.heightMedium,
                AnimationListViewCard(
                  index: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLoginButton(context),
                      SpaceConstant.instance.heightXSmall,
                      // _buildForgotPasswordText(),
                      _buildSkipLogin(),
                      SpaceConstant.instance.heightXSmall,
                    ],
                  ),
                ),
                SpaceConstant.instance.heightLarge,
                const Spacer(),
                AnimationListViewCard(index: 3, child: _buildSignInButton()),
                SpaceConstant.instance.heightSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeSignInByPhoneOrEmail({bool isOutlineBorder = false}) {
    return CustomAnimationVisibility(
      // visible: context.isKeyboardVisible(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: AuthCustomButton(
          fontWeight: FontWeight.w500,
          onTap: () async {
            userNameController.text = '';
            signUpByEmail = !signUpByEmail;
            setState(() {});

            await Future.delayed(const Duration(milliseconds: 100));

            userNameFocusNode.requestFocus();
          },
          isOutlineBorder: isOutlineBorder,
          text: signUpByEmail ? 'login_by_phone' : 'login_by_email',
          size: 12.sp,
        ),
      ),
    );
  }

  Widget _buildUserNameField() {
    return AuthTextField(
      controller: userNameController,
      icon: _getPlatformIcon(CupertinoIcons.at, Icons.alternate_email_rounded),
      label: 'E-mail',
      maxLength: 40,
      textInputAction: TextInputAction.next,
      textType: TextInputType.emailAddress,
      focusNode: userNameFocusNode,
      onEditingComplete: () => passwordFocusNode.requestFocus(),
    );
  }

  Widget _buildPasswordField() {
    return ValueListenableBuilder<bool>(
      valueListenable: showPasswordText,
      builder: (context, value, child) {
        return AuthTextField(
          maxLength: 24,
          suffixIcon: _buildPasswordToggle(value),
          passwordText: value,
          validator: (value) => value!.isEmpty ? 'empty_password' : null,
          controller: passwordController,
          icon: _getPlatformIcon(CupertinoIcons.padlock, Icons.key_sharp),
          textType: TextInputType.emailAddress,
          focusNode: passwordFocusNode,
          label: 'Password',
        );
      },
    );
  }

  IconButton _buildPasswordToggle(bool isVisible) {
    return IconButton(
      onPressed: () => showPasswordText.value = !isVisible,
      icon: Icon(
        _getPlatformIcon(
          isVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
        color: context.inverse.withOpacity(.8),
      ),
    );
  }

  IconData _getPlatformIcon(IconData iosIcon, IconData androidIcon) {
    return Platform.isIOS || Platform.isMacOS ? iosIcon : androidIcon;
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AuthCustomButton(onTap: () {}, text: 'Login'),
    );
  }

  Widget _buildForgotPasswordText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: Txt(
          text: 'forgot_password',
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: context.inverse.withOpacity(.7),
          family: FontFamilyEnum.enInter.rawValue,
        ),
      ),
    );
  }

  Widget _buildSkipLogin() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          await SPManager.instance.setSkipLoginStatus();

          Provider.of<LayoutController>(
            context,
            listen: false,
          ).bottomNavTabFunc(0, navigatorToMainPage: true);

          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavScreen.routeName,
            (route) => false,
            arguments: true,
          );
        },
        child: Txt(
          text: 'Skip Login',
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: context.inverse.withOpacity(.7),
          family: FontFamilyEnum.enInter.rawValue,
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Txt(
      text: 'Welcome back!'.toUpperCase(),
      fontWeight: FontWeight.bold,
      maxLines: 1,
      textAlign: TextAlign.center,
      family: FontFamilyEnum.enSora.rawValue,
      letterSpacing: .4,
      fontSize: 14.5.sp,
    );
  }

  Widget _buildDescriptionText() {
    return Txt(
      text: 'Please log in to access your account',
      fontWeight: FontWeight.w400,
      textAlign: TextAlign.center,
      family: FontFamilyEnum.enInter.rawValue,
      color: context.inverse.withOpacity(.7),
      fontSize: 13.sp,
      letterSpacing: .3,
      maxLines: 3,
    );
  }

  Widget _buildSignInButton() {
    return CustomAnimationVisibility(
      visible: context.isKeyboardVisible(),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, SignUpScreen.routeName);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              text: 'Don\'t have an account?',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: context.inverse.withOpacity(.7),
              family: FontFamilyEnum.enInter.rawValue,
            ),
            SpaceConstant.instance.widthXXSmall,
            Txt(
              text: 'Sign up',
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              color: ColorConstants.instance.primary,
              family: FontFamilyEnum.enInter.rawValue,
            ),
          ],
        ),
      ),
    );
  }
}
