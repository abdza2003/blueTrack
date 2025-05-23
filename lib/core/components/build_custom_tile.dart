import 'dart:io'; // إضافة المكتبة للتحقق من نوع النظام
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';

class BuildCustomTile extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final Function()? onTap;
  final String? subtitleString;
  final Widget? trailing;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;

  const BuildCustomTile({
    required this.title,
    this.leadingIcon,
    required this.onTap,
    this.subtitleString,
    this.trailing,
    this.icon,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      // if (1 == 1) {
      // استخدام التصميم المتوافق مع iOS أو macOS
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: context.onBackground,
            borderRadius: borderRadius ?? BorderRadius.zero,
          ),
          child: CupertinoListTile(
            padding:
                (trailing is Switch)
                    ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.5.h)
                    : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.5.h),
            leading:
                icon ??
                SizedBox(
                  height: 100.h,
                  child: Icon(leadingIcon, color: CupertinoColors.systemGrey),
                ),
            title: Txt(
              enableCircel: false,
              text: title,
              color: context.inverse.withOpacity(.8),
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
            ),
            subtitle:
                subtitleString == null
                    ? null
                    : Txt(
                      enableRtl: false,
                      text: subtitleString!,
                      color: context.inverse.withOpacity(.6),
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      enableCircel: false,
                    ),
            trailing:
                trailing ??
                const Icon(
                  CupertinoIcons.forward,
                  color: CupertinoColors.systemGrey,
                ),
            onTap: onTap,
          ),
        ),
      );
    } else {
      // استخدام التصميم المتوافق مع Android أو أنظمة أخرى
      return ListTile(
        minLeadingWidth: 0,
        subtitle:
            subtitleString == null
                ? null
                : Txt(
                  enableRtl: false,
                  text: subtitleString!,
                  color: context.inverse.withOpacity(.6),
                  fontWeight: FontWeight.normal,
                  fontSize: 11.sp,
                  enableCircel: false,
                ),
        title: Txt(
          enableCircel: false,
          text: title,
          color: context.inverse.withOpacity(.8),
          fontWeight: FontWeight.normal,
          fontSize: 13.sp,
        ),
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: CupertinoColors.systemGrey,
            ),
        leading: SizedBox(
          height: 100.h,
          child: icon ?? Icon(leadingIcon, color: CupertinoColors.systemGrey),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
      );
    }
  }
}
