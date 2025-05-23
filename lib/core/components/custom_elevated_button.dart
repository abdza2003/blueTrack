import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final OutlinedBorder? shape;
  final String txt;
  final Widget? child;
  final Size? size;
  const CustomElevatedButton({
    this.onPressed,
    this.color,
    this.size,
    this.shape,
    this.txt = '',
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        backgroundColor: color,
        shape: shape ?? BorderConstant.instance.radiusAllSmallCiruclar,
        padding: const EdgeInsets.all(0),
      ),
      onPressed: onPressed,
      child:
          child ??
          Txt(
            fontSize: 12.sp,
            enableCircel: false,
            enableAutoSize: true,
            text: txt,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
