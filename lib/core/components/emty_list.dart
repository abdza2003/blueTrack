import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';

class CustomEmptyList extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? assetImage;
  final EdgeInsetsGeometry? padding;

  const CustomEmptyList({
    super.key,
    required this.text,
    this.padding,
    this.icon,
    this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          if (padding == null) SpaceConstant.instance.heightXXLarge,
          Container(
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
            decoration: BoxDecoration(
              borderRadius: BorderConstant.instance.allSmallCircular,
              color: ColorConstants.instance.primary.withOpacity(.1),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (assetImage != null)
                  Opacity(
                    opacity: 1,
                    child: Image.asset(
                      assetImage!,
                      width: 50.w,
                      height: 50.h,
                      color: ColorConstants.instance.primary.withOpacity(.7),
                    ),
                  )
                else if (icon != null)
                  Opacity(
                    opacity: 0.7,
                    child: Icon(
                      icon,
                      size: 40.r,
                      color: ColorConstants.instance.primary,
                    ),
                  ),
                SpaceConstant.instance.heightSmall,
                Txt(
                  text: text,
                  height: context.langCode() == 'ar' ? 1.4 : 1.2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  family: FontFamilyEnum.enInter.rawValue,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
