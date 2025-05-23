import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluetrack/core/components/custom_text_faild.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final dynamic icon;
  final bool? readOnly;
  final bool passwordText;
  final int? maxLength;
  final TextInputType? textType;
  final int? maxLine;
  final String? Function(String?)? validator;
  final void Function()? onTab;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  const AuthTextField({
    super.key,
    this.readOnly,
    this.passwordText = false,
    this.suffixIcon,
    this.hintText,
    this.textType,
    this.maxLine,
    this.maxLength,
    this.onEditingComplete,
    this.validator,
    this.focusNode,
    required this.controller,
    required this.icon,
    this.textInputAction,
    this.label,
    this.onTab,
  });

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  // استخدام ValueNotifier لتخزين TextDirection
  final ValueNotifier<TextDirection> _textDirectionNotifier =
      ValueNotifier<TextDirection>(TextDirection.ltr);

  @override
  void dispose() {
    _textDirectionNotifier.dispose();
    super.dispose();
  }

  // دالة لتحديث اتجاه النص بناءً على اللغة
  void _updateTextDirection(String text) {
    final newDirection =
        _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
    _textDirectionNotifier.value = newDirection;
  }

  // دالة للتحقق إذا كان النص باللغة العربية
  bool _isArabic(String text) {
    if (text.isNotEmpty) {
      final firstChar = text.codeUnitAt(0);
      return (firstChar >= 0x0600 && firstChar <= 0x06FF) || // Arabic
          (firstChar >= 0x0750 && firstChar <= 0x077F) || // Arabic Supplement
          (firstChar >= 0x08A0 && firstChar <= 0x08FF) || // Arabic Extended-A
          (firstChar >= 0xFB50 &&
              firstChar <= 0xFDFF) || // Arabic Presentation Forms-A
          (firstChar >= 0xFE70 &&
              firstChar <= 0xFEFF); // Arabic Presentation Forms-B
    }
    return false;
  }

  // دالة لعرض TextField لأجهزة Android
  Widget _buildMaterialTextField() {
    return CustomTextField(
      textInputAction: widget.textInputAction,
      textType: widget.textType,
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      passwordText: widget.passwordText,
      validator: widget.validator,
      onChanged: _updateTextDirection,
      readOnly: widget.readOnly ?? false,
      onTab: widget.onTab,
      maxLine: widget.maxLine ?? 1,
      labelText: widget.label,
      controller: widget.controller,
      maxLength: widget.maxLength,
      hintText: widget.hintText ?? widget.label,
      suffixIcon: widget.suffixIcon,
      prefixIcon:
          widget.icon is IconData
              ? Icon(
                widget.icon,
                size: 20.r,
                color: context.inverse.withOpacity(.8),
              )
              : widget.icon as Widget,
      nullCounterText: true,
      borderRadius: BorderConstant.instance.allSmallCircular,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderConstant.instance.allSmallCircular,
        borderSide: BorderSide(
          color: ColorConstants.instance.primary,
          width: 1.5.r,
        ),
      ),
    );
  }

  // دالة لعرض CupertinoTextField لأجهزة iOS
  Widget _buildCupertinoTextField() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: context.onBackground,
      shape: BorderConstant.instance.radiusAllMediumCircular,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderConstant.instance.allMediumCircular,
          border: Border.all(
            color: context.border.withOpacity(.12),
            width: 1.6.r,
          ),
        ),
        child: CupertinoFormRow(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Expanded(
                child: CupertinoTextFormFieldRow(
                  onChanged: (value) {
                    _updateTextDirection(value);
                    if (widget.validator != null) {
                      widget.validator!(value); // Add validation logic here
                    }
                  },

                  style: TextStyle(color: context.inverse),
                  controller: widget.controller,
                  obscureText: widget.passwordText,
                  readOnly: widget.readOnly ?? false,
                  keyboardType: widget.textType,
                  maxLines: widget.maxLine ?? 1,
                  maxLength: widget.maxLength,
                  placeholder: widget.hintText ?? widget.label,
                  validator: widget.validator,

                  prefix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child:
                        widget.icon is IconData
                            ? Icon(
                              widget.icon,
                              size: 20.r,
                              color: context.inverse.withOpacity(.8),
                            )
                            : widget.icon as Widget,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.w,
                    vertical: 10.h,
                  ),
                  textInputAction: widget.textInputAction,
                  onEditingComplete: widget.onEditingComplete,
                  focusNode: widget.focusNode,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderConstant.instance.allMediumCircular,
                  //   color: context.onBackground,
                  //   border: Border.all(
                  //     color: context.border,
                  //     width: 1.5.r,
                  //   ),
                  // ),
                ),
              ),
              if (widget.suffixIcon != null) widget.suffixIcon!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextDirection>(
      valueListenable: _textDirectionNotifier,
      builder: (context, textDirection, child) {
        // تحديد الجهاز الحالي وعرض الحقل المناسب
        return Directionality(
          textDirection: textDirection,
          child:
              Platform.isIOS || Platform.isMacOS
                  ? _buildCupertinoTextField() // عرض CupertinoTextField لنظام iOS
                  : _buildMaterialTextField(), // عرض TextField لنظام Android
        );
      },
    );
  }
}
