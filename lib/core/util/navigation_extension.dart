// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:provider/provider.dart';

extension NavigatorStateExtension on NavigatorState {
  Future<T?> pushWithBottomNavControl<T extends Object?>(
    BuildContext context,
    Route<T> route, {
    bool hideBottomNav = false,
    bool rerutnShowBottomNav = true,
  }) async {
    // تحديث حالة الـ BottomNavigationBar
    if (hideBottomNav) {
      Provider.of<LayoutController>(
        context,
        listen: false,
      ).hideBottomNav(true); // إخفاء شريط التنقل
    }

    // الانتقال إلى الصفحة
    final result = await push(route);

    // العودة إلى وضع الـ BottomNavigationBar الطبيعي عند العودة من الصفحة
    if (rerutnShowBottomNav) {
      Provider.of<LayoutController>(
        context,
        listen: false,
      ).hideBottomNav(false); // إظهار شريط التنقل
    }

    return result;
  }
}
