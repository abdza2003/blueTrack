// Profile Header with Avatar and Name
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/animation_list_view_card.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:provider/provider.dart';

class BuildProfileCoverAndPictureSection extends StatefulWidget {
  const BuildProfileCoverAndPictureSection({super.key});

  @override
  State<BuildProfileCoverAndPictureSection> createState() =>
      _BuildProfileCoverAndPictureSectionState();
}

class _BuildProfileCoverAndPictureSectionState
    extends State<BuildProfileCoverAndPictureSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationListViewCard(
      index: 0,
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                _buildBackgroundImage(
                  context,
                  ImageConstant.instance.onboarding2,
                ),
                _buildProfileAvatar(context),
              ],
            ),
          ),
          SpaceConstant.instance.heightLarge,
          // Txt(
          //   text: controller.userInfoDto?.name ?? '',
          //   fontSize: 14.sp,
          // ),
          Txt(text: 'User Name', fontSize: 14.sp),
          SpaceConstant.instance.heightXXSmall,
          // Txt(
          //   text: controller.userInfoDto?.phone ??
          //       controller.userInfoDto?.email ??
          //       '',
          Txt(
            text: 'user@gmail.com',
            fontWeight: FontWeight.normal,
            fontSize: 11.sp,
            color: context.border.withOpacity(.3),
          ),
        ],
      ),
    );
  }
}

// Background Image for Header
Widget _buildBackgroundImage(BuildContext context, String imagePath) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    width: context.phoneWidth(),
    height: 120.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(imagePath),
        opacity: .75,
      ),
      color: ColorConstants.instance.primary.withOpacity(.1),
      borderRadius: BorderConstant.instance.allSmallCircular,
    ),
  );
}

// Profile Avatar
Widget _buildProfileAvatar(BuildContext context) {
  return Positioned(
    bottom: -16.h,
    child: CircleAvatar(
      radius: 15.2 * pi,
      backgroundColor: context.background,
      child: CircleAvatar(
        radius: 14 * pi,
        backgroundColor: ColorConstants.instance.primary.withOpacity(.2),
        child: CircleAvatar(
          radius: 13.5 * pi,
          backgroundColor: context.onBackground,
          child: Container(
            alignment: Alignment.center,
            child: Txt(
              text: 'UN',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: context.inverse.withOpacity(.6),
              family: FontFamilyEnum.enSora.rawValue,
            ),
          ),
        ),
      ),
    ),
  );
}
