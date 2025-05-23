import 'package:flutter/material.dart';

class BorderConstant {
  static final BorderConstant instance = BorderConstant._internal();

  BorderConstant._internal();

  final radiusAllXXXLargeCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(38));
  final radiusAllXXLargeCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));
  final radiusAllXLargeCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(24));
  final radiusAllLargeCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  final radiusAllMediumCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  final radiusAllSmallCiruclar =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
  final radiusAllXSmallCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
  final radiusAllXXSmallCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(2));
  final radiusAllZeroCircular =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));

  final allXXXLargeCircular = BorderRadius.circular(38);
  final allXXLargeCircular = BorderRadius.circular(24);
  final allLargeCircular = BorderRadius.circular(16);
  final allxMediumCircular = BorderRadius.circular(12);
  final allMediumCircular = BorderRadius.circular(10);
  final allSmallCircular = BorderRadius.circular(8);
  final allXSmallCircular = BorderRadius.circular(4);
  final allXXSmallCircular = BorderRadius.circular(2);
}
