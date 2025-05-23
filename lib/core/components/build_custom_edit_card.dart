import 'package:bluetrack/core/components/animation_list_view_card.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCustomEditCard extends StatelessWidget {
  final List<Widget> tiles;
  final int index;
  const BuildCustomEditCard({
    required this.tiles,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationListViewCard(
      // verticalOffset: 140.0,
      // durationMilliseconds: 450,
      index: index,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(color: context.border, width: 1.2.r),
          ),
          child: Column(children: tiles),
        ),
      ),
    );
  }
}
