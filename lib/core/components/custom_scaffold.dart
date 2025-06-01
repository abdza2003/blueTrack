import 'dart:io'; // للتعرف على نظام التشغيل

import 'package:bluetrack/core/components/custom_debug_error_messages.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String previousPageTitle;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color? appbarIosBackgroundColor;
  final Color? appbarAndroidBackgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final bool nestedScrollView;
  final bool showAppbar;
  final Color? androidAppbarColor;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.child,
    this.leading,
    this.previousPageTitle = '',
    this.trailing,
    this.bottomNavigationBar,
    this.showAppbar = true,
    this.androidAppbarColor,
    this.backgroundColor,
    this.appbarAndroidBackgroundColor,
    this.appbarIosBackgroundColor,
    this.drawer,
    this.endDrawer,
    this.nestedScrollView = false,
  });

  @override
  Widget build(BuildContext context) {
    // تخصيص معالجة الأخطاء
    FlutterError.onError = (FlutterErrorDetails details) {
      // طباعة تفاصيل الخطأ في وحدة التحكم
      FlutterError.dumpErrorToConsole(details);

      // خيار إضافي: يمكنك تسجيل الخطأ في نظام تتبع الأخطاء هنا مثل Firebase Crashlytics
      // FirebaseCrashlytics.instance.recordFlutterError(details);
    };

    // تخصيص ويدجت الخطأ
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return ErrorWidgetClass(errorDetails);
    };

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoPageScaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor ?? context.background,

        navigationBar:
            nestedScrollView
                ? null
                : showAppbar
                ? CupertinoNavigationBar(
                  border: null,

                  backgroundColor: context.onBackground,

                  // backgroundColor:
                  //     appbarIosBackgroundColor ?? context.onBackground,
                  previousPageTitle: previousPageTitle,
                  middle: Txt(
                    text: title,
                    fontSize: 14.6.sp,
                    enableAutoSize: true,
                    color: context.inverse,
                    fontWeight: FontWeight.w500,
                  ),
                  leading: leading,
                  trailing: trailing,
                )
                : null,
        child: Builder(
          builder: (_) {
            if (nestedScrollView) {
              return NestedScrollView(
                headerSliverBuilder:
                    (context, innerBoxIsScrolled) => [
                      CupertinoSliverNavigationBar(
                        leading: leading,
                        trailing: trailing,
                        previousPageTitle: previousPageTitle,
                        backgroundColor:
                            appbarIosBackgroundColor ?? context.background,
                        largeTitle: Txt(
                          text: title,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        middle: Txt(
                          text: title,
                          fontSize: 14.6.sp,
                          enableAutoSize: true,
                          color: context.inverse,
                          fontWeight: FontWeight.w500,
                        ),
                        alwaysShowMiddle: false,
                      ),
                    ],
                body: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Material(color: context.background, child: child),
                ),
              );
            } else {
              return SafeArea(
                top: false,
                bottom: false,
                child: Material(color: context.background, child: child),
              );
            }
          },
        ),

        /*  */
      );
    } else {
      return Scaffold(
        key: key,
        backgroundColor: backgroundColor ?? context.background,
        appBar:
            showAppbar
                ? AppBar(
                  toolbarHeight: 40.h,
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(color: context.inverse),
                  title: Txt(
                    text: title,
                    fontSize: 14.2.sp,
                    enableAutoSize: true,
                    color: androidAppbarColor ?? context.inverse,
                    fontWeight: FontWeight.w500,
                  ),
                  leading: leading,
                  actions: trailing != null ? [trailing!] : null,
                  backgroundColor:
                      appbarAndroidBackgroundColor ?? context.onBackground,
                )
                : null,
        bottomNavigationBar: bottomNavigationBar,
        body: child,
        drawer: drawer,
        endDrawer: endDrawer,
      );
    }
  }
}
