import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/view/layout/components/bottom_nav_item.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class BottomNavBarWidget extends StatefulWidget {
  final onItemSelected;
  const BottomNavBarWidget({required this.onItemSelected, super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late LayoutController appController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appController = Provider.of<LayoutController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        // borderRadius: BorderConstant.instance.allXXXLargeCircular,
        border: Border.all(color: context.border.withOpacity(.2), width: 1.2.r),
      ),
      child: Container(
        // opacity: 1,
        decoration: const BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.only(top: 1.r),
        child: Selector<LayoutController, Tuple2>(
          selector: (p0, p1) => Tuple2(p1.selectedIndex, p1.items),
          builder: (context, value, child) {
            return FABBottomAppBar(
              index: value.item1,
              height: 55.h,
              iconSize: 20.r,
              backgroundColor: context.onBackground,
              color: context.border.withOpacity(.4),
              selectedColor: ColorConstants.instance.primary,
              onTabSelected: widget.onItemSelected,
              items: value.item2,
            );
          },
        ),
      ),
    );
  }
}
