import 'package:flutter/cupertino.dart';
import 'package:bluetrack/controller/layout/i_layout_controller.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/view/layout/components/bottom_nav_item.dart';
import 'package:bluetrack/view/navigations/cart_navigator.dart';
import 'package:bluetrack/view/navigations/favorite_navigator.dart';
import 'package:bluetrack/view/navigations/home_navigator.dart';
import 'package:bluetrack/view/navigations/profile_navigator.dart';

class LayoutController extends ILayoutController {
  LayoutController() {
    _initializeScrollControllers();
  }

  // تعريف المتغيرات

  // قائمة للمراقبة الخاصة بالتمرير لكل صفحة
  final Map<int, ScrollController> scrollControllers = {};

  // المتغير لحفظ الصفحة الحالية
  int selectedIndex = 0;

  // حالة إخفاء BottomNavigationBar
  bool _isBottomNavHidden = false;

  // الحصول على حالة إخفاء BottomNavigationBar
  bool get isBottomNavHidden => _isBottomNavHidden;

  // متغير لتخزين الوقت الذي تم فيه الضغط على التاب الأخير
  DateTime? lastTabClickTime;

  // دالة لتغيير حالة إخفاء/عرض BottomNavigationBar
  void hideBottomNav(bool hide) {
    _isBottomNavHidden = hide;
    notifyListeners(); // إشعار المستمعين (الـ Widgets التي تستخدم الـ LayoutController)
  }

  // المتغير للصفحة الحالية في الـ PageController
  PageController pageController = PageController(initialPage: 0);

  /// دالة التعامل مع الضغطات على الأزرار في BottomNavigationBar
  @override
  Future<void> bottomNavTabFunc(
    int index, {
    bool navigatorToMainPage = false,
  }) async {
    // الرجوع إلى الصفحة الأولية
    GlobalKey<NavigatorState> key =
        index == 0
            ? homeNavigatorKey
            : index == 1
            ? cartNavigatorKey
            : index == 2
            ? favoriteNavigatorKey
            : profileNavigatorKey;

    int oldIndex = selectedIndex;
    GlobalKey<NavigatorState> oldKey =
        oldIndex == 0
            ? homeNavigatorKey
            : oldIndex == 1
            ? cartNavigatorKey
            : oldIndex == 2
            ? favoriteNavigatorKey
            : profileNavigatorKey;

    // التحقق من وجود الـ PageController
    if (pageController.hasClients) {
      // إذا كانت الصفحة الحالية هي نفسها، نقوم بالتمرير للأعلى
      if (pageController.page?.round() == index) {
        scrollToTop(scrollControllers[index]!);
      } else {
        if (navigatorToMainPage) {
          if (key.currentContext != null) {
            if (Navigator.canPop(key.currentContext!)) {
              _navigateToInitialPage(key);
            }
          }
        }
        // التنقل إلى الصفحة المحددة

        _navigateToPage(index);

        //todo : سطر جديد تحت التيست
        if (Navigator.canPop(oldKey.currentContext!)) {
          _navigateToInitialPage(oldKey);
        }
      }
    }

    // إذا تم الضغط على نفس الـ index مرتين في وقت قريب
    if (lastTabClickTime != null &&
        DateTime.now().difference(lastTabClickTime!).inMilliseconds < 500 &&
        selectedIndex == index) {
      if (key.currentContext != null) {
        if (Navigator.canPop(key.currentContext!)) {
          _navigateToInitialPage(key);
        } else {
          // إذا لم يكن بإمكانك الرجوع، لا تفعل شيئًا
        }
      }
    }

    selectedIndex = index;
    notifyListeners();

    // تحديث الوقت بعد كل ضغطة
    lastTabClickTime = DateTime.now();
  }

  // دالة للانتقال إلى الصفحة الأولية عند الضغط مرتين على نفس الـ Tab
  void _navigateToInitialPage(GlobalKey<NavigatorState> navigationKey) {
    // إرجاع الـ Navigator إلى الصفحة الأولية
    Navigator.of(navigationKey.currentContext!).pushNamedAndRemoveUntil(
      (navigationKey.currentState?.widget as Navigator).initialRoute ?? '',
      (route) => false,
    );
  }

  /// دالة للتنقل بين الصفحات
  Future<void> _navigateToPage(int index) async {
    final int currentIndex = pageController.page?.toInt() ?? 0;

    if ((index - currentIndex).abs() > 1) {
      // إذا كانت الصفحة بعيدة، قم بالانتقال بدون حركة انسيابية
      pageController.jumpToPage(index);
    } else {
      // الانتقال إلى الصفحة المجاورة بحركة انسيابية
      await pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // دالة للتمرير إلى الأعلى في الصفحة
  void scrollToTop(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // قائمة العناصر التي تظهر في الـ BottomNavigationBar
  List<FABBottomAppBarItem> get items => [
    FABBottomAppBarItem(
      iconDataOutline: ImageConstant.instance.homeiconoutline,
      iconData: ImageConstant.instance.homeicon,
      text: "Home",
    ),
    FABBottomAppBarItem(
      iconDataOutline: ImageConstant.instance.analyitics,
      iconData: ImageConstant.instance.analyitics,
      text: "Statistics",
    ),

    FABBottomAppBarItem(
      iconDataOutline: ImageConstant.instance.user1,
      iconData: ImageConstant.instance.user2,
      text: "Profile",
    ),
  ];

  // دالة لتهيئة الـ ScrollControllers لكل صفحة
  void _initializeScrollControllers() {
    scrollControllers[0] = ScrollController(); // الصفحة الرئيسية (Home)
    scrollControllers[1] = ScrollController(); // صفحة السلة (Cart)
    scrollControllers[2] = ScrollController(); // صفحة المفضلة (Favorite)
    scrollControllers[3] = ScrollController(); // صفحة الملف الشخصي (Profile)
  }

  // قائمة من مفاتيح الـ Navigator الخاصة بكل صفحة
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    homeNavigatorKey,
    cartNavigatorKey,
    favoriteNavigatorKey,
    profileNavigatorKey,
  ];
}
