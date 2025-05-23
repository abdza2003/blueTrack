import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

customBottomSheat(BuildContext context, {Widget? child}) {
  return showMaterialModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    context: context,
    builder:
        (context) => Container(
          decoration: BoxDecoration(
            // color: context.onBackground,
            // color: Colors.orange,
            color: context.onBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          width: context.phoneWidth(),
          // height: 160.h,
          padding: PaddingAndMarginConstant.instance.allSmall,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: child,
          ),
        ),
  );
}
