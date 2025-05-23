import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:flutter/material.dart';

class Txt extends StatefulWidget {
  final String text;
  final int? maxLines;
  final double fontSize;
  final double height;
  final double? logoFontSize;
  final String? family;
  final String? familyAr;
  final double? offsetAppName;
  final double letterSpacing;
  final Color? color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final bool enableRtl;
  final bool enableCircel;
  final bool enableAutoSize;
  final int? maxLength; // Add maxLength property

  const Txt({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.family,
    this.offsetAppName,
    this.decoration = TextDecoration.none,
    this.height = 0.0,
    this.letterSpacing = 0.0,
    this.enableCircel = true,
    this.familyAr,
    this.maxLines, // Default maxLines to 1
    this.textAlign = TextAlign.start,
    this.color,
    this.enableAutoSize = false,
    this.logoFontSize,
    this.enableRtl = true,
    this.fontWeight = FontWeight.w500,
    this.maxLength, // Initialize maxLength
  });

  @override
  State<Txt> createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  TextDirection getTextDirection(String text) {
    if (text.isEmpty) {
      return TextDirection.ltr;
    }
    final arabicRegExp = RegExp(r'[\u0600-\u06FF]+');
    return arabicRegExp.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  String _truncateText(String text, {int? maxLength}) {
    if (maxLength != null && text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final text = _truncateText(widget.text, maxLength: widget.maxLength);

    if (widget.enableAutoSize) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text.rich(
          TextSpan(children: _getTextSpans(text)),
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,

          overflow:
              widget.maxLines != null
                  ? TextOverflow.ellipsis
                  : null, // Adds an ellipsis to truncated text
          textDirection: widget.enableRtl ? getTextDirection(text) : null,
        ),
      );
    } else {
      return Text.rich(
        TextSpan(children: _getTextSpans(text)),
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.maxLines != null ? TextOverflow.ellipsis : null,
        textDirection: widget.enableRtl ? getTextDirection(text) : null,
      );
    }
  }

  List<TextSpan> _getTextSpans(String text) {
    final List<TextSpan> spans = [];

    final arabicRegExp = RegExp(r'[\u0600-\u06FF]+');

    // Split text into words (preserving spaces)
    final words = text.split(' ');

    for (final word in words) {
      String trimmedWord = word.trim(); // Remove unnecessary spaces

      TextStyle textStyle = getTextStyle(
        height: widget.height,
        fontFamily:
            (arabicRegExp.hasMatch(trimmedWord)
                ? widget.familyAr ?? FontFamilyEnum.ar.rawValue
                : widget.family ?? FontFamilyEnum.enSora.rawValue),
        letterSpacing: widget.letterSpacing,
        color: widget.color ?? context.inverse,
        fontSize: widget.fontSize,
        decoration: widget.decoration,
        // decorationStyle: TextDecorationStyle.wavy,
        fontWeight: widget.fontWeight,
      );

      if (trimmedWord.isEmpty) {
        // If the word is empty (e.g., due to spaces), just continue
        spans.add(TextSpan(text: ' ', style: textStyle));
        continue;
      }

      // Regular text (no match with email/phone/url)
      spans.add(TextSpan(text: word, style: textStyle));

      // Add a space after each word to preserve original spaces
      if (words.lastIndexWhere((w) => w == word) != words.length - 1) {
        spans.add(TextSpan(text: ' ', style: textStyle));
      }
    }

    return spans;
  }
}

TextStyle getTextStyle({
  required String fontFamily,
  required Color color,
  double fontSize = 16,
  double? letterSpacing,
  double? height,
  FontWeight fontWeight = FontWeight.normal,
  TextDecoration? decoration,
  TextDecorationStyle? decorationStyle,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decorationThickness: 1.2.h,
    decorationStyle: decorationStyle,
    decorationColor: color,
    letterSpacing: letterSpacing,
    height: height,
    decoration: decoration,
  );
}
