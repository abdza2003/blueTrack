import 'dart:io';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/animation_list_view_card.dart';
import 'package:bluetrack/core/components/auth_custom_button.dart';
import 'package:bluetrack/core/components/custom_animation_visibility.dart';
import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/view/auth/components/auth_text_faild.dart';
import 'package:bluetrack/view/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({this.isOpenKeyboard = true, super.key});
  final bool isOpenKeyboard;
  static const String routeName = 'signup_route';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late ValueNotifier<bool> showPasswordText;
  late final FocusNode userNameFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode fullNameFocusNode;
  late bool signUpByEmail = true;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    showPasswordText = ValueNotifier(true);
    passwordFocusNode = FocusNode();
    userNameFocusNode = FocusNode();
    fullNameFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpaceConstant.instance.heightXXXLarge,
                SpaceConstant.instance.heightXXXLarge,
                _buildLogoHeader(),
                SpaceConstant.instance.heightLarge,
                AnimationListViewCard(index: 1, child: _buildFullNamdField()),
                SpaceConstant.instance.heightSmall,

                AnimationListViewCard(
                  index: 1,
                  child: Visibility(
                    visible: signUpByEmail,
                    replacement: _buildEmailField(),
                    child: _buildEmailField(),
                  ),
                ),
                SpaceConstant.instance.heightSmall,

                AnimationListViewCard(index: 1, child: _buildPasswordField()),
                SpaceConstant.instance.heightSmall,
                // AnimationListViewCard(index: 2, child: _buildGenderSelection()),
                SpaceConstant.instance.heightMedium,
                AnimationListViewCard(index: 2, child: _buildSignUpButton()),
                SpaceConstant.instance.heightSmall,
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

  Widget _buildLogoHeader() {
    return Column(
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
        SpaceConstant.instance.heightXSmall,
        _buildDescriptionText(),
      ],
    );
  }

  Widget _buildHeaderText() {
    return Txt(
      text: 'Start your journey with BlueTrack'.toUpperCase(),
      fontWeight: FontWeight.bold,
      maxLines: 1,
      textAlign: TextAlign.center,
      fontSize: 12.sp,
    );
  }

  Widget _buildDescriptionText() {
    return Txt(
      text: 'Create your account now',
      fontWeight: FontWeight.w400,
      textAlign: TextAlign.start,
      color: context.inverse.withOpacity(.7),
      fontSize: 14.sp,
      maxLines: 3,
    );
  }

  Widget _buildEmailField() {
    return AuthTextField(
      controller: emailController,
      icon: Platform.isIOS ? CupertinoIcons.at : Icons.alternate_email_rounded,
      label: 'E-Mail',
      maxLength: 40,
      textInputAction: TextInputAction.next,
      textType: TextInputType.emailAddress,
      focusNode: userNameFocusNode,
      onEditingComplete: () => passwordFocusNode.requestFocus(),
    );
  }

  Widget _buildFullNamdField() {
    return AuthTextField(
      controller: userNameController,
      maxLength: 35,
      icon: Platform.isIOS ? CupertinoIcons.person : Icons.person_outline,
      label: 'Username',
      textInputAction: TextInputAction.next,
      textType: TextInputType.name,
      focusNode: fullNameFocusNode,
      onEditingComplete: () => userNameFocusNode.requestFocus(),
    );
  }

  Widget _buildPasswordField() {
    return ValueListenableBuilder<bool>(
      valueListenable: showPasswordText,
      builder: (context, value, child) {
        return AuthTextField(
          maxLength: 50,
          suffixIcon: IconButton(
            onPressed: () => showPasswordText.value = !value,
            icon: Icon(
              value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: context.inverse.withOpacity(.8),
            ),
          ),
          passwordText: value,
          controller: passwordController,
          icon: Platform.isIOS ? CupertinoIcons.padlock : Icons.key_sharp,
          textType: TextInputType.visiblePassword,
          focusNode: passwordFocusNode,
          label: 'Password',
        );
      },
    );
  }

  Widget _buildSignUpButton({bool isOutlineBorder = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AuthCustomButton(
        onTap: () async {},
        isOutlineBorder: isOutlineBorder,
        text: 'Create Account',
      ),
    );
  }

  Widget _buildSignInButton() {
    return CustomAnimationVisibility(
      visible: context.isKeyboardVisible(),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              text: 'Have an account?',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: context.inverse.withOpacity(.7),
              family: FontFamilyEnum.enInter.rawValue,
            ),
            SpaceConstant.instance.widthXXSmall,
            Txt(
              text: 'Sign in',
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
