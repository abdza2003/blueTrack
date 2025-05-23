import 'dart:io';
import 'dart:math';

import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';

class NewSnackBar {
  static getSnackBar({
    required BuildContext context,
    required String value,
    required Widget icon,
    int seconds = 1,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(_temp(icon, value, context, seconds));
  }

  static getDoneSnackBar({
    required BuildContext context,
    required String value,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      _temp(
        CircleAvatar(
          backgroundColor:
              CupertinoColors.activeGreen, // تخصيص اللون بناءً على الحالة
          radius: 4 * pi,
          child: Padding(
            padding: EdgeInsets.all(1.r),
            child: Icon(
              CupertinoIcons
                  .check_mark_circled, // تخصيص الأيقونة بناءً على الحالة
              color: CupertinoColors.white,
              size: 18.r,
            ),
          ),
        ),
        value,
        context,
        seconds,
        borderColor: CupertinoColors.activeGreen,
        color: context.onBackground,
      ),
    );
  }

  static getNoInternetSnackBar({
    required BuildContext context,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      _temp(
        Icon(
          Icons.rss_feed_outlined,
          size: 15.r,
          color: ColorConstants.instance.white,
        ),
        'noInternetConnection',
        context,
        seconds,
      ),
    );
  }

  static getErrorSnackBar({
    required BuildContext context,
    int seconds = 2,
    required String value,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      _temp(
        CircleAvatar(
          backgroundColor:
              CupertinoColors.systemRed, // تخصيص اللون بناءً على الحالة
          radius: 4 * pi,
          child: Padding(
            padding: EdgeInsets.all(1.r),
            child: Icon(
              CupertinoIcons.clear_circled,
              size: 18.r,
              color: CupertinoColors.white,
            ),
          ),
        ),
        value,
        context,
        seconds,
        borderColor: CupertinoColors.systemRed,
        color: context.onBackground,
      ),
    );
  }

  static SnackBar _temp(
    Widget icon,
    String value,
    BuildContext context,
    int seconds, {
    Color? color,
    Color? borderColor,
  }) {
    return SnackBar(
      backgroundColor: color ?? ColorConstants.instance.brightGray,
      behavior: SnackBarBehavior.floating,
      shape: BorderConstant.instance.radiusAllSmallCiruclar,
      elevation: .2,
      // margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      padding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderConstant.instance.allSmallCircular,
          border: Border.all(
            color: (borderColor ?? Colors.white).withOpacity(.4),
            width: 1.r,
          ),
        ),
        child: Row(
          children: [
            icon,
            SpaceConstant.instance.widthXSmall,
            Expanded(
              child: Txt(
                text: value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                // family: FontFamilyEnum.enInter.rawValue,
                color: context.inverse.withOpacity(.7),
              ),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: seconds),
    );
  }
}
