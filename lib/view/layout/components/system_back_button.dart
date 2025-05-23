import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/view/navigations/home_navigator.dart';

Future<bool> systemBackButtonPressed(
  LayoutController appController,
  GlobalKey<NavigatorState> navigatorKey,
  int index,
) async {
  if (navigatorKey.currentState?.canPop() == true) {
    navigatorKey.currentState?.pop(navigatorKey.currentContext);
    return false;
  } else {
    // التحقق إذا كان المستخدم في الصفحة الرئيسية
    if (navigatorKey == homeNavigatorKey) {
      // إذا لم يكن التمرير في أعلى الصفحة
      if (appController.scrollControllers[0]!.offset > 0) {
        appController.scrollToTop(
          appController.scrollControllers[0]!,
        ); // إرجاع التمرير للأعلى
        return false; // التعامل مع الحدث بدون الخروج من التطبيق
      } else {
        // إذا كان المستخدم بالفعل في أعلى الصفحة، أظهر مربع حوار التأكيد
        bool shouldExit = await exitMessageDialog(
          content: 'exit_body_message',
          message: 'exit_title',
          navigatorKey.currentContext!,
        );
        if (shouldExit) {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
        return shouldExit;
      }
    } else if (navigatorKey != homeNavigatorKey) {
      if (appController.scrollControllers[index]!.offset > 0) {
        appController.scrollToTop(
          appController.scrollControllers[index]!,
        ); // إرجاع التمرير للأعلى
        return false; // التعامل مع الحدث بدون الخروج من التطبيق
      } else {
        appController.bottomNavTabFunc(0);
        return false;
      }
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true; // Indicate that the back action is handled
    }
  }
}

Future exitMessageDialog(
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
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
        onPressed: () => Navigator.of(context).pop(true), // تأكيد الخروج
        child: Txt(
          text: 'yes',
          fontSize: 12.sp,
          color: ColorConstants.instance.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
        onPressed: () => Navigator.of(context).pop(false), // تأكيد الخروج
        child: Txt(
          text: 'no',
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
        onPressed: () => Navigator.of(context).pop(true), // تأكيد الخروج
        child: Txt(
          text: 'yes',
          fontSize: 12.sp,
          color: ColorConstants.instance.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      CupertinoDialogAction(
        onPressed: () => Navigator.of(context).pop(false), // تأكيد الخروج
        child: Txt(
          text: 'no',
          fontSize: 12.sp,
          color: ColorConstants.instance.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
