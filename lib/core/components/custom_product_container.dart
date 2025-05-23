import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';

class ProductCustomContainer extends StatelessWidget {
  final Widget child;
  const ProductCustomContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.phoneHeight() * .,
      // width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderConstant.instance.allXXLargeCircular,
        border: Border.all(color: context.border, width: 1.5.r),
      ),
      child: child,
    );
  }
}
