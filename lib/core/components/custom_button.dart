import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';

class APPCustomButton extends StatefulWidget {
  final void Function()? onTap;
  final dynamic text;
  final double? size;
  final double? buttonHeight;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final bool isOutlineBorder;
  final bool isLoading;
  final Color? borderColor;
  final Color? backgroundColor;

  const APPCustomButton({
    required this.onTap,
    required this.text,
    this.fontWeight,
    this.borderRadius,
    this.backgroundColor,
    this.buttonHeight,
    this.borderColor,
    this.isOutlineBorder = false,
    this.isLoading = false,
    this.size,
    super.key,
  });

  @override
  _APPCustomButtonState createState() => _APPCustomButtonState();
}

class _APPCustomButtonState extends State<APPCustomButton> {
  final ValueNotifier<bool> _isPressed = ValueNotifier<bool>(false);

  void _handleTapDown(TapDownDetails details) {
    _isPressed.value = true;
  }

  void _handleTapUp(TapUpDetails details) {
    _isPressed.value = false;
  }

  void _handleTapCancel() {
    _isPressed.value = false;
  }

  @override
  void dispose() {
    _isPressed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPressed,
      builder: (context, value, child) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.symmetric(horizontal: value ? 3 : 0.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: widget.isLoading ? .4 : 1,
                child: _buildButton(context),
              ),
              if (widget.isLoading)
                SizedBox(
                  height: 25.r,
                  width: 25.r,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2.2.r,
                    semanticsValue: '',
                    strokeCap: StrokeCap.round,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    if (1 == 1) {
      return SizedBox(
        height: widget.buttonHeight ?? 40.h,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius:
              widget.borderRadius ??
              BorderConstant.instance.allXXXLargeCircular,
          color:
              widget.isOutlineBorder == true
                  ? Colors.transparent
                  : widget.isLoading
                  ? widget.backgroundColor != null
                      ? widget.backgroundColor!.withOpacity(.0)
                      : ColorConstants.instance.primary.withOpacity(.0)
                  : widget.backgroundColor ?? ColorConstants.instance.primary,
          onPressed:
              widget.onTap == null
                  ? null
                  : widget.isLoading
                  ? () {}
                  : () async {
                    _isPressed.value = true;
                    await Future.delayed(const Duration(milliseconds: 90));
                    _isPressed.value = false;
                    await Future.delayed(const Duration(milliseconds: 20));
                    widget.onTap!();
                  },
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  widget.borderRadius ??
                  BorderConstant.instance.allXXXLargeCircular,
              border: Border.all(
                color: widget.borderColor ?? ColorConstants.instance.primary,
                width: 1.0.r,
              ),
            ),
            alignment: Alignment.center,
            width: context.phoneHeight(),
            child:
                !widget.isLoading
                    ? widget.text is String
                        ? Txt(
                          color:
                              widget.isOutlineBorder == true
                                  ? context.inverse
                                  : Colors.white,
                          letterSpacing: .4.sp,
                          fontSize: widget.size ?? 16.sp,
                          text: widget.text,
                          fontWeight: widget.fontWeight ?? FontWeight.w800,
                          family: FontFamilyEnum.enInter.rawValue,
                        )
                        : widget.text is Widget
                        ? widget.text
                        : const SizedBox()
                    : const SizedBox(),
          ),
        ),
      );
    } else {
      return Material(
        color:
            widget.isOutlineBorder == true
                ? Colors.transparent
                : widget.isLoading
                ? widget.backgroundColor != null
                    ? widget.backgroundColor!.withOpacity(.0)
                    : ColorConstants.instance.primary.withOpacity(.0)
                : widget.backgroundColor ?? ColorConstants.instance.primary,
        borderRadius:
            widget.borderRadius ?? BorderConstant.instance.allXXXLargeCircular,
        child: InkWell(
          borderRadius:
              widget.borderRadius ??
              BorderConstant.instance.allXXXLargeCircular,
          onTap:
              widget.onTap == null
                  ? null
                  : widget.isLoading
                  ? () {}
                  : () async {
                    _isPressed.value = true;
                    await Future.delayed(const Duration(milliseconds: 90));
                    _isPressed.value = false;
                    await Future.delayed(const Duration(milliseconds: 20));
                    widget.onTap!();
                  },
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  widget.borderRadius ??
                  BorderConstant.instance.allXXXLargeCircular,
              border: Border.all(
                color: widget.borderColor ?? ColorConstants.instance.primary,
                width: 1.0.r,
              ),
            ),
            alignment: Alignment.center,
            height: widget.buttonHeight ?? 40.h,
            width: context.phoneHeight(),
            child:
                !widget.isLoading
                    ? widget.text is String
                        ? Txt(
                          color:
                              widget.isOutlineBorder == true
                                  ? context.inverse
                                  : Colors.white,
                          letterSpacing: .4.sp,
                          fontSize: widget.size ?? 16.sp,
                          text: widget.text,
                          fontWeight: widget.fontWeight ?? FontWeight.w800,
                          family: FontFamilyEnum.enInter.rawValue,
                        )
                        : widget.text is Widget
                        ? widget.text
                        : const SizedBox()
                    : const SizedBox(),
          ),
        ),
      );
    }
  }
}
