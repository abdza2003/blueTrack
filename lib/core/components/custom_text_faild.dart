import 'dart:core';

import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? passwordText;
  final Function(String?)? press;
  final TextDirection? textDirection;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? textType;
  final void Function()? onTab;
  final bool? nullCounterText;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatter;
  final bool? enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? fillColor;
  final Color? focusColor;
  final bool? filled;
  final void Function()? onEditingComplete;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final EdgeInsets? scrollPadding;
  const CustomTextField({
    super.key,
    this.contentPadding,
    this.scrollPadding,
    this.hintText,
    this.focusedBorder,
    this.labelText,
    this.prefixIcon,
    this.onEditingComplete,
    this.suffixIcon,
    this.passwordText,
    this.press,
    this.validator,
    this.textDirection,
    this.errorText,
    this.initialValue,
    this.controller,
    this.minLine,
    this.maxLine,
    this.maxLength,
    this.textType,
    this.onTab,
    this.nullCounterText,
    this.padding,
    this.inputFormatter,
    this.enabled,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintStyle,
    this.labelStyle,
    this.style,
    this.borderRadius,
    this.borderSide,
    this.fillColor,
    this.focusColor,
    this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.r),
      child: TextFormField(
        scrollPadding: scrollPadding ?? EdgeInsets.zero,
        textInputAction: textInputAction,
        focusNode: focusNode,
        enabled: enabled,
        textDirection: textDirection,
        initialValue: initialValue,
        controller: controller,
        onEditingComplete: onEditingComplete,
        obscureText: passwordText == null ? false : passwordText!,
        readOnly: readOnly,
        decoration: InputDecoration(
          isDense: true,
          fillColor: fillColor ?? context.onBackground,
          filled: true,
          focusedBorder:
              focusedBorder ??
              OutlineInputBorder(
                borderRadius:
                    borderRadius ?? BorderConstant.instance.allSmallCircular,
                borderSide: BorderSide(
                  color: ColorConstants.instance.primary,
                  width: 1.8,
                ),
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? BorderConstant.instance.allSmallCircular,
            borderSide: BorderSide(color: context.border, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? BorderConstant.instance.allSmallCircular,
            borderSide: const BorderSide(color: Colors.red, width: 1.6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? BorderConstant.instance.allSmallCircular,
            borderSide: const BorderSide(color: Colors.red, width: 1.6),
          ),
          errorStyle: TextStyle(color: Colors.red, fontSize: 10.sp),
          hintText: hintText,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          labelText: labelText,
          counterText: nullCounterText == true ? '' : null,
          focusColor: focusColor,
          hoverColor: focusColor,
          // contentPadding:
          //     contentPadding ?? PaddingAndMarginConstant.instance.allZero,
        ),
        keyboardType: textType,
        onSaved: press,
        onTap: onTab,
        validator: validator,
        minLines: minLine,
        maxLines: maxLine,
        maxLength: maxLength,
        inputFormatters: inputFormatter,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        style: style,
      ),
    );
  }
}
