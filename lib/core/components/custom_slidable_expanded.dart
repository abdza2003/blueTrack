import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlidableExpanded extends StatelessWidget {
  final List<Widget> children;
  const CustomSlidableExpanded({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        // color: Colors.orange,
        margin: EdgeInsets.symmetric(horizontal: 7.w),
        // elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.border, width: 1.5.r),
            // color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: context.phoneWidth(),
          height: context.phoneHeight(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}
