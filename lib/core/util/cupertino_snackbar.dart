import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';

void showCupertinoSnackBar(
  BuildContext context, {
  String? title,
  required String message,
  IconData? icon,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder:
        (BuildContext context) => CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          message: Row(
            children: [
              CircleAvatar(
                backgroundColor: CupertinoColors.activeGreen,
                radius: 4 * pi,
                child: Padding(
                  padding: EdgeInsets.all(1.r),
                  child: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: CupertinoColors.white,
                    size: 17.r,
                  ),
                ),
              ),
              Expanded(
                child: Txt(
                  text: message,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
  );

  // إغلاقه بعد ثانيتين
  Future.delayed(const Duration(milliseconds: 1600), () {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // إغلاق الـ CupertinoActionSheet مع أنيميشن
    }
  });
}
