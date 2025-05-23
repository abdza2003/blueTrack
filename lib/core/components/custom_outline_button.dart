import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'dart:io';

import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final dynamic child; // يمكن أن يكون نصًا أو ويدجتًا
  final EdgeInsetsGeometry? padding;
  final double? fontSize; // حجم الخط للنص
  final FontWeight? fontWeight; // وزن الخط للنص

  final double? height;

  const CustomOutlineButton({
    required this.onPressed,
    required this.child,
    this.padding,
    this.height,
    this.fontSize,
    this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: buildCupertinoButton(
          context,
          onPressed: onPressed,
          child: child,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
        ),
      );
    } else {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: buildMaterialButton(
          context,
          onPressed: onPressed,
          child: child,
          height: height,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
    }
  }
}

// دالة زر iOS
Widget buildCupertinoButton(
  BuildContext context, {
  required void Function()? onPressed,
  required dynamic child,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    alignment: Alignment.center,
    onPressed: onPressed,
    child: Container(
      height: height ?? 30.h,
      alignment: Alignment.center,
      width: context.phoneWidth(),
      decoration: BoxDecoration(
        borderRadius: BorderConstant.instance.allSmallCircular,
        border: Border.all(
          color: ColorConstants.instance.primary.withOpacity(.5),
          width: 1.2.r,
        ),
      ),
      child:
          child is String
              ? Txt(
                text: child,
                fontSize:
                    fontSize ??
                    15.sp, // استخدام الحجم المدخل أو الحجم الافتراضي
                fontWeight:
                    fontWeight ??
                    FontWeight
                        .normal, // استخدام الوزن المدخل أو الوزن الافتراضي
                family: FontFamilyEnum.enInter.rawValue,
              )
              : child,
    ),
  );
}

// دالة زر Android
Widget buildMaterialButton(
  BuildContext context, {
  required void Function()? onPressed,
  required dynamic child,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
}) {
  return Material(
    color: context.onBackground,
    borderRadius: BorderConstant.instance.allSmallCircular,
    child: InkWell(
      borderRadius: BorderConstant.instance.allSmallCircular,
      onTap: onPressed,
      child: Container(
        height: height ?? 30.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderConstant.instance.allSmallCircular,
          border: Border.all(
            color: ColorConstants.instance.primary.withOpacity(.5),
            width: 1.2.r,
          ),
        ),
        width: context.phoneWidth(),
        child:
            child is String
                ? Txt(
                  text: child,
                  fontSize:
                      fontSize ??
                      15.sp, // استخدام الحجم المدخل أو الحجم الافتراضي
                  fontWeight:
                      fontWeight ??
                      FontWeight
                          .normal, // استخدام الوزن المدخل أو الوزن الافتراضي
                  family: FontFamilyEnum.enInter.rawValue,
                )
                : child,
      ),
    ),
  );
}
