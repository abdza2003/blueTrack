// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/custom_animation_visibility.dart';
import 'package:bluetrack/view/layout/components/bottom_nav_bar_widget.dart';
import 'package:bluetrack/view/layout/components/system_back_button.dart';
import 'package:bluetrack/view/layout/layout_screen.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = 'bottomNav_screen';

  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late LayoutController appController;

  @override
  void initState() {
    super.initState();
    appController = Provider.of<LayoutController>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LayoutController, Tuple2>(
      selector:
          (context, layoutController) => Tuple2(
            layoutController.isBottomNavHidden,
            layoutController.selectedIndex,
          ),
      builder: (context, values, child) {
        return WillPopScope(
          onWillPop:
              () => systemBackButtonPressed(
                appController,
                appController.navigatorKeys[values.item2],
                values.item2,
              ),
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: CustomAnimationVisibility(
              duration: const Duration(milliseconds: 250),
              visible: !(values.item1), // تغيير الشفافية
              child: BottomNavBarWidget(
                onItemSelected:
                    (index) => Future.delayed(Duration.zero, () {
                      appController.bottomNavTabFunc(index);
                    }),
              ),
            ),
            body: LayoutScreen(pageController: appController.pageController),
          ),
        );
      },
    );
  }
}
