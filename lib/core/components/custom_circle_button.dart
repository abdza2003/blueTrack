import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolsCircleButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onTap;
  const ToolsCircleButton({
    required this.onTap,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        // width: 58.w,
        height: 57.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: context.background, width: 5.r),
          shape: BoxShape.circle,
          // color: Colors.white,
        ),
        child: Icon(iconData, size: 18.r),
      ),
    );
  }
}
