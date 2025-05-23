import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/enum/share_routes_enum.dart';
import 'package:bluetrack/core/extension/share_routes_extension.dart';
import 'package:bluetrack/core/util/EncryptionUtil.dart';
import 'package:bluetrack/view/layout/components/bottom_nav_item.dart';
import 'package:bluetrack/view/navigations/cart_navigator.dart';
import 'package:bluetrack/view/navigations/favorite_navigator.dart';
import 'package:bluetrack/view/navigations/home_navigator.dart';
import 'package:bluetrack/view/navigations/profile_navigator.dart';
import 'package:provider/provider.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:tuple/tuple.dart';

class LayoutScreen extends StatefulWidget {
  final PageController pageController;

  const LayoutScreen({required this.pageController, super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

GlobalKey<NavigatorState> layoutNavigatorKey = GlobalKey<NavigatorState>();

class _LayoutScreenState extends State<LayoutScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   _initializeAppLinks();
    // });

    return Selector<LayoutController, bool>(
      builder: (context, value, child) {
        return PageView(
          key: layoutNavigatorKey,
          // physics: values
          //     ? const NeverScrollableScrollPhysics()
          //     : const CustomScrollPhysics(sensitivity: 5.0), // تقليل الحساسية
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.pageController,
          onPageChanged: (index) {
            FABBottomAppBar.globalKey.currentState?.updateCurrentIndex(index);
          },
          children: const [
            HomeNavigator(),
            CartNavigator(),
            ProfileNavigator(),
          ],
        );
      },
      selector: (p0, p1) => p1.isBottomNavHidden,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomScrollPhysics extends BouncingScrollPhysics {
  final double sensitivity;

  const CustomScrollPhysics({this.sensitivity = 1.0, super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      sensitivity: sensitivity,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return super.applyPhysicsToUserOffset(position, offset / sensitivity);
  }
}
