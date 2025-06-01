import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSectionsCardButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color? color;
  final void Function()? onTap;

  const CustomSectionsCardButton({
    required this.title,
    required this.iconPath,
    this.color,
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderConstant.instance.allMediumCircular,
      child: Stack(
        alignment: Alignment.topRight,
        // clipBehavior: Clip.none,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: BorderConstant.instance.radiusAllMediumCircular,
            child: ClipRRect(
              borderRadius: BorderConstant.instance.allMediumCircular,
              child: InkWell(
                borderRadius: BorderConstant.instance.allMediumCircular,

                customBorder: BorderConstant.instance.radiusAllMediumCircular,
                onTap: onTap,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Ink(
                      width: context.phoneWidth(),
                      height: context.phoneHeight(),
                      decoration: BoxDecoration(
                        color: color ?? ColorConstants.instance.primary,
                        borderRadius: BorderConstant.instance.allMediumCircular,
                      ),
                      child: Padding(
                        padding: PaddingAndMarginConstant.instance.allXSmall,
                        child: Txt(
                          text: title,
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15.h,
                      left: -20.w,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45.r,
                      ),
                    ),
                    Positioned(
                      left: 10.w,
                      bottom: 15.h,
                      child: Image.asset(
                        iconPath,
                        width: 40.r,
                        color: color ?? ColorConstants.instance.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -20.w,
            top: -10.h,
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.white.withOpacity(.3),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 60.h,
            child: CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.white.withOpacity(.2),
            ),
          ),
        ],
      ),
    );
  }
}
