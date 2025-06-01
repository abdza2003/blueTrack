import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioListTileWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final int value;
  final int groubValue;
  final IconData? iconData;
  final void Function(int?)? onChanged;
  const RadioListTileWidget({
    this.title,
    this.subtitle,
    required this.groubValue,
    required this.value,
    this.onChanged,
    this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: RadioListTile(
        fillColor: WidgetStatePropertyAll(ColorConstants.instance.primary),
        activeColor: ColorConstants.instance.primary,
        value: value,
        groupValue: groubValue,
        onChanged: onChanged,
        title: Txt(text: '$title', fontSize: 12.sp, enableCircel: false),
        secondary: Icon(iconData, size: 20.r),
        subtitle: Txt(
          enableCircel: false,
          text: '$subtitle',
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
