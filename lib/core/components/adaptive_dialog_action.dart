import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:io';

import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart'; // لاستعمال Platform

void showPlatformSpecificDialog(
  BuildContext context,
  String title,
  String content,
  Function onYesPressed,
) {
  if (Platform.isIOS) {
    showIOSDialog(context, title, content, onYesPressed);
  } else if (Platform.isAndroid) {
    showAndroidDialog(context, title, content, onYesPressed);
  }
}

void showIOSDialog(
  BuildContext context,
  String title,
  String content,
  Function onYesPressed,
) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Txt(
          text: title,
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
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              onYesPressed(); // استدعاء الدالة عند الضغط على "نعم"
              Navigator.of(context).pop('Yes');
            },
            child: Txt(
              text: 'yes',
              fontWeight: FontWeight.w500,
              color: ColorConstants.instance.primary,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop('No');
            },
            child: Txt(
              text: 'no',
              fontWeight: FontWeight.w500,
              color: ColorConstants.instance.primary,
            ),
          ),
        ],
      );
    },
  ).then((value) {
    // التعامل مع النتيجة بعد إغلاق الحوار
    print('تم اختيار: $value');
  });
}

void showAndroidDialog(
  BuildContext context,
  String title,
  String content,
  Function onYesPressed,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
        titlePadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
        title: Txt(
          text: title,
          letterSpacing: .4,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        content: Txt(
          text: content,
          color: context.inverse.withOpacity(.8),
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onYesPressed(); // استدعاء الدالة عند الضغط على "نعم"
              Navigator.of(context).pop('Yes');
            },
            child: Txt(
              text: 'yes',
              fontWeight: FontWeight.w500,
              color: ColorConstants.instance.primary,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('No');
            },
            child: Txt(
              text: 'no',
              fontWeight: FontWeight.w500,
              color: ColorConstants.instance.primary,
            ),
          ),
        ],
      );
    },
  ).then((value) {
    // التعامل مع النتيجة بعد إغلاق الحوار
    print('تم اختيار: $value');
  });
}
