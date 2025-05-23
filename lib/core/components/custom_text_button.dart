import 'package:bluetrack/core/components/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final double? size;
  final void Function()? onPressed;
  const AuthTextButton({
    required this.text,
    this.size,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Txt(
        text: text,
        fontSize: size ?? 12.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
