import 'package:bluetrack/core/components/custom_border.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Icon icon;

  const CustomIconButton({required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      boxShape: BoxShape.circle,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.white),
          onPressed: onTap,
          icon: icon,
        ),
      ),
    );
  }
}
