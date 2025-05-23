import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaddingAndMarginConstant {
  static final PaddingAndMarginConstant instance =
      PaddingAndMarginConstant._internal();

  PaddingAndMarginConstant._internal();

  //All
  final pagePading = EdgeInsets.all(10.r);
  final authPagePadding = EdgeInsets.all(15.r);

  ///all:32.r
  final allXXLarge = EdgeInsets.all(32.r);

  ///all:24.r
  final allXLarge = EdgeInsets.all(24.r);

  ///all:20.r
  final allLarge = EdgeInsets.all(20.r);

  ///all:16.r
  final allMedium = EdgeInsets.all(16.r);

  ///all:12.r
  final allSmall = EdgeInsets.all(12.r);

  ///all:8.r
  final allXSmall = EdgeInsets.all(8.r);

  ///all:4.r
  final allXXSmall = EdgeInsets.all(4.r);

  ///all:2.r
  final allXXXSmall = EdgeInsets.all(2.r);

  ///all:0.r
  final allZero = EdgeInsets.all(0.r);

  // Only Top

  ///top:16.h
  final topMedium = EdgeInsets.only(top: 16.h);

  ///top:8.h
  final topSmall = EdgeInsets.only(top: 8.h);

  //Only Bottom

  ///bottom:32.h
  final bottomXLarge = EdgeInsets.only(bottom: 32.h);

  //Symmetric

  ///horizontal: 16.w, vertical: 10.h
  final symmetricMedium =
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h);

  ///horizontal: horizontal: 6.w, vertical: 4.h
  final symmetricSmall = EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h);

  ///horizontal: horizontal: horizontal: 32.w, vertical: 8.h
  final symmetricLarge = EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h);

  //Horizontal
  ///horizontal: 8.w
  final symmetricHorizontalSmall = EdgeInsets.symmetric(horizontal: 8.w);

  ///horizontal: 4.w
  final symmetricHorizontalXSmall = EdgeInsets.symmetric(horizontal: 4.w);

  ///horizontal: 2.w
  final symmetricHorizontalXXSmall = EdgeInsets.symmetric(horizontal: 2.w);

  ///horizontal: 16.w
  final symmetricHorizontalMedium = EdgeInsets.symmetric(horizontal: 16.w);

  ///horizontal: 20.w
  final symmetricHorizontalLarge = EdgeInsets.symmetric(horizontal: 20.w);

  ///horizontal: 30.w
  final symmetricHorizontalXLarge = EdgeInsets.symmetric(horizontal: 30.w);

  //Vertical
  final symmetricVerticalXLarge = EdgeInsets.symmetric(vertical: 10.h);

  ///vertical: 24.h, horizontal: 0.h
  final verticalMedium = EdgeInsets.symmetric(vertical: 24.h, horizontal: 0.h);
}
