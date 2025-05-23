import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'dart:io' show Platform;

class FABBottomAppBarItem {
  FABBottomAppBarItem({
    required this.iconData,
    required this.iconDataOutline,
    required this.text,
    this.count,
    this.shape,
    this.id,
  });
  int? id;
  String iconData;
  String iconDataOutline;
  String text;
  int? count;
  ShapeBorder? shape;
}

class FABBottomAppBar extends StatefulWidget {
  static final GlobalKey<FABBottomAppBarState> globalKey =
      GlobalKey<FABBottomAppBarState>();

  FABBottomAppBar({
    Key? key,
    required this.items,
    this.centerItemText,
    this.height = 60.0,
    required this.index,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.fontSize,
    this.notchedShape,
    this.width,
    required this.onTabSelected,
  }) : super(key: globalKey);

  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final int index;
  final double? width;
  final double? fontSize;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();

  static FABBottomAppBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<FABBottomAppBarState>();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  late final ValueNotifier<int> selectedIndexNotifier;

  void updateIndex(int index) {
    widget.onTabSelected(index);
    selectedIndexNotifier.value = index;
  }

  void updateCurrentIndex(int index) {
    selectedIndexNotifier.value = index;
  }

  @override
  void initState() {
    super.initState();
    selectedIndexNotifier = ValueNotifier(widget.index);
  }

  @override
  void dispose() {
    selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        List<Widget> items = List.generate(widget.items.length, (int index) {
          return _buildTabItem(
            item: widget.items[index],
            index: index,
            selectedIndex: selectedIndex,
            onPressed: updateIndex,
          );
        });
        items.insert(items.length >> 1, _buildMiddleTabItem());

        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Card(
            elevation: 0,
            color: context.background,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Opacity(
              opacity: 1,
              child: BottomAppBar(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                notchMargin: 10,
                shape: const CircularNotchedRectangle(),
                color: widget.backgroundColor?.withOpacity(1),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required int selectedIndex,
    required ValueChanged<int> onPressed,
  }) {
    return Platform.isIOS || Platform.isMacOS
        ? _buildIosTabItem(
          item: item,
          index: index,
          selectedIndex: selectedIndex,
          onPressed: onPressed,
        )
        : _buildAndroidTabItem(
          item: item,
          index: index,
          selectedIndex: selectedIndex,
          onPressed: onPressed,
        );
  }

  Widget _buildIosTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required int selectedIndex,
    required ValueChanged<int> onPressed,
  }) {
    Color? color = selectedIndex == index ? widget.selectedColor : widget.color;
    return SizedBox(
      width: widget.width ?? context.phoneWidth() * .25,
      height: widget.height,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onPressed(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage(item.iconData),
              size: widget.iconSize,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroidTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required int selectedIndex,
    required ValueChanged<int> onPressed,
  }) {
    Color? color = selectedIndex == index ? widget.selectedColor : widget.color;
    String? iconData = selectedIndex == index ? item.iconData : item.iconData;
    return SizedBox(
      width: widget.width ?? context.phoneWidth() * .33,
      height: widget.height,
      child: Material(
        shape: item.shape ?? BorderConstant.instance.radiusAllZeroCircular,
        type: MaterialType.transparency,
        child: InkWell(
          customBorder:
              item.shape ?? BorderConstant.instance.radiusAllZeroCircular,
          onTap: () => onPressed(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageIcon(
                AssetImage(iconData),
                size: widget.iconSize,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
