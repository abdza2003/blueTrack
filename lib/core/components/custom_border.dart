import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBorder extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Widget child;
  final double? padding;
  final BoxShape boxShape;
  const CustomBorder({
    required this.child,
    this.borderRadius,
    this.padding,
    this.boxShape = BoxShape.rectangle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: boxShape,
        borderRadius:
            boxShape == BoxShape.circle
                ? null
                : borderRadius ?? BorderConstant.instance.allXXXLargeCircular,
        gradient: LinearGradient(colors: ColorConstants.instance.primaryColors),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              borderRadius ?? BorderConstant.instance.allXXXLargeCircular,
        ),
        margin: EdgeInsets.all(padding ?? 1.4.r),
        child: child,
      ),
    );
  }
}
