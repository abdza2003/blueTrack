import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceConstant {
  static final SpaceConstant instance = SpaceConstant._internal();

  SpaceConstant._internal();

  // Height

  ///height: 50.h
  final heightXXXLarge = SizedBox(height: 50.h);

  ///height: 30.hs
  final heightXXLarge = SizedBox(height: 30.h);

  ///height: 25.h
  final heightXLarge = SizedBox(height: 25.h);

  ///height: 20.h
  final heightLarge = SizedBox(height: 20.h);

  ///height: 15.h
  final heightMedium = SizedBox(height: 15.h);

  ///height: 10.h
  final heightSmall = SizedBox(height: 10.h);

  ///height: 5.h
  final heightXSmall = SizedBox(height: 5.h);

  ///height: 2.5.h
  final heightXXSmall = SizedBox(height: 2.5.h);

  // Width

  ///width: 50.w
  final widthXXXLarge = SizedBox(width: 50.w);

  ///width: 30.w
  final widthXXLarge = SizedBox(width: 30.w);

  ///width: 25.w
  final widthXLarge = SizedBox(width: 25.w);

  ///width: 20.w
  final widthLarge = SizedBox(width: 20.w);

  ///width: 15.w
  final widthMedium = SizedBox(width: 15.w);

  ///width: 10.w
  final widthSmall = SizedBox(width: 10.w);

  ///width: 5.w
  final widthXSmall = SizedBox(width: 5.w);

  ///width: 2.5.w
  final widthXXSmall = SizedBox(width: 2.5.w);

  // All

  ///width: 25.r and height: 25.r
  final allXLarge = SizedBox(width: 25.r, height: 25.r);

  ///width: 20.r and height: 20.r
  final allLarge = SizedBox(width: 20.r, height: 20.r);

  ///width: 15.r and height: 15.r
  final allMedium = SizedBox(width: 15.r, height: 15.r);

  ///width: 10.r and height: 10.r
  final allSmall = SizedBox(width: 10.r, height: 10.r);
}
