// Gradient Card
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';

class BuildDiscountAndCopunsSection extends StatelessWidget {
  final String imagePath;
  final String text;
  const BuildDiscountAndCopunsSection({
    required this.imagePath,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          _buildCardBackground(context, imagePath),
          _buildGradientOverlay(context),
          _buildCardText(text),
        ],
      ),
    );
  }
}

// Card Background
Widget _buildCardBackground(BuildContext context, String imagePath) {
  return Container(
    alignment: Alignment.bottomCenter,
    width: context.phoneWidth(),
    height: 70.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
        image: AssetImage(imagePath),
      ),
      color: context.border,
      borderRadius: BorderConstant.instance.allxMediumCircular,
    ),
  );
}

// Gradient Overlay
Widget _buildGradientOverlay(BuildContext context) {
  return Container(
    width: context.phoneWidth(),
    height: 70.h,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.black.withOpacity(0.15),
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.15),
        ],
      ),
      borderRadius: BorderConstant.instance.allxMediumCircular,
    ),
  );
}

// Card Text
Widget _buildCardText(String text) {
  return Positioned(
    child: Container(
      alignment: Alignment.center,
      height: 70.h,
      child: Txt(
        text: text.toUpperCase(),
        color: Colors.white,
        enableAutoSize: true,
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
    ),
  );
}
