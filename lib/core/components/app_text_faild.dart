import 'dart:io';

import 'package:bluetrack/core/components/custom_text_faild.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class APPTextFaild extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatter;
  final bool showLable;
  final int? maxLine;
  final String? headTitle;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function()? onTab;
  final Widget? suffixIcon;
  final void Function(String?)? onChanged;
  const APPTextFaild({
    super.key,
    this.readOnly,
    this.onChanged,
    this.maxLength,
    this.headTitle,
    this.showLable = true,
    this.focusNode,
    this.textInputAction,
    this.suffixIcon,
    this.inputFormatter,
    this.maxLine,
    required this.controller,
    this.prefixIcon,
    required this.label,
    this.onTab,
  });

  @override
  _APPTextFaildState createState() => _APPTextFaildState();
}

class _APPTextFaildState extends State<APPTextFaild> {
  final ValueNotifier<TextDirection> _textDirection =
      ValueNotifier<TextDirection>(TextDirection.ltr);

  void _updateTextDirection(String text) {
    _textDirection.value =
        _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headTitle != null) Txt(text: '  ${widget.headTitle}'),
        if (widget.headTitle != null) SpaceConstant.instance.heightXSmall,
        if (Platform.isMacOS || Platform.isIOS)
          CupertinoTextField(
            decoration: BoxDecoration(
              color: context.onBackground,
              borderRadius: BorderConstant.instance.allSmallCircular,
              border: Border.all(color: context.border, width: 1.5.r),
            ),
            readOnly: widget.readOnly ?? false,
            onTap: widget.onTab,
            focusNode: widget.focusNode,
            textDirection: _textDirection.value,
            placeholder: widget.label,
            autofillHints: const ['dsfds'],
            placeholderStyle: TextStyle(color: Colors.grey.shade500),
            prefix: widget.prefixIcon,
            onChanged: _updateTextDirection,
            inputFormatters: widget.inputFormatter,
            suffix: widget.suffixIcon,
            padding: PaddingAndMarginConstant.instance.allSmall,
            maxLines: widget.maxLine,
            minLines: 1,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            keyboardType: TextInputType.multiline,
            style: TextStyle(color: context.inverse),
          )
        else
          ValueListenableBuilder<TextDirection>(
            valueListenable: _textDirection,
            builder: (context, direction, child) {
              return CustomTextField(
                minLine: 1,
                maxLength: widget.maxLength,
                textInputAction: widget.textInputAction,
                textDirection: direction,
                onChanged: _updateTextDirection,
                readOnly: widget.readOnly ?? false,
                onTab: widget.onTab,
                maxLine: widget.maxLine ?? 1,
                labelText:
                    widget.headTitle == null
                        ? widget.showLable == true
                            ? widget.label
                            : null
                        : null,
                controller: widget.controller,
                hintText: widget.label,
                suffixIcon: widget.suffixIcon,
                focusNode: widget.focusNode,
                prefixIcon: widget.prefixIcon,
                inputFormatter: widget.inputFormatter,
                borderRadius: BorderConstant.instance.allSmallCircular,
              );
            },
          ),
      ],
    );
  }
}

class APPSearchTextFaild extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final EdgeInsetsGeometry? padding;
  final TextInputAction? textInputAction;
  const APPSearchTextFaild({
    required this.controller,
    required this.label,
    super.key,
    this.focusNode,
    this.padding,
    this.textInputAction,
  });

  @override
  _APPSearchTextFaildState createState() => _APPSearchTextFaildState();
}

class _APPSearchTextFaildState extends State<APPSearchTextFaild> {
  final ValueNotifier<TextDirection> _textDirection =
      ValueNotifier<TextDirection>(TextDirection.ltr);

  void _updateTextDirection(String text) {
    _textDirection.value =
        _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Platform.isMacOS || Platform.isIOS)
          CupertinoSearchTextField(
            padding: widget.padding ?? EdgeInsets.all(10.r),
            onChanged: _updateTextDirection,
            placeholderStyle: TextStyle(color: Colors.grey.shade500),
            style: TextStyle(color: context.inverse),
            controller: widget.controller,
            focusNode: widget.focusNode,
            placeholder: widget.label,
          )
        else
          ValueListenableBuilder<TextDirection>(
            valueListenable: _textDirection,
            builder: (context, direction, child) {
              return TextField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                onChanged: _updateTextDirection,
                textDirection: direction,
                style: TextStyle(color: context.inverse),
                decoration: InputDecoration(
                  hintText: widget.label,
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: context.border, width: 1.r),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: context.border, width: 1.r),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              );
            },
          ),
      ],
    );
  }
}
