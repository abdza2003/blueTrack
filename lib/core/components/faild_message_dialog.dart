import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';

Future filadMessageDialog(
  BuildContext context, {
  required String content,
  required String message,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      if (Platform.isIOS || Platform.isMacOS) {
        return iosFaildMessage(context, content: content, message: message);
      } else {
        return androidFaildMessage(context, content: content, message: message);
      }
    },
  );
}

androidFaildMessage(
  BuildContext context, {
  required String content,
  required String message,
}) {
  return AlertDialog(
    content: Txt(
      text: content,
      color: context.inverse.withOpacity(.8),
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Txt(
          text: 'try_again',
          fontSize: 12.sp,
          color: ColorConstants.instance.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
    actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
    titlePadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
    title: Txt(
      text: message,
      letterSpacing: .4,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}

iosFaildMessage(
  BuildContext context, {
  required String content,
  required String message,
}) {
  return CupertinoAlertDialog(
    title: Txt(
      text: message,
      letterSpacing: .4,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    content: Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Txt(
        text: content,
        color: context.inverse.withOpacity(0.8),
        fontSize: 12.sp,
      ),
    ),
    actions: [
      CupertinoDialogAction(
        onPressed: () => Navigator.pop(context),
        child: Txt(
          text: 'try_again',
          fontSize: 12.sp,
          color: ColorConstants.instance.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
