import 'dart:io';

import 'package:bluetrack/view/analyitics/analyitics_screen.dart';
import 'package:bluetrack/view/auth/login_screen.dart';
import 'package:bluetrack/view/auth/signup_screen.dart';
import 'package:bluetrack/view/home/home_screen.dart';
import 'package:bluetrack/view/layout/bottom_nav_screen.dart';
import 'package:bluetrack/view/profile/profile_screen.dart';
import 'package:bluetrack/view/start/onboarding_screen.dart';
import 'package:bluetrack/view/start/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

String? lastVisitedPage;
// خريطة للـ Routes
final Map<String, Widget Function(BuildContext, dynamic)> routeBuilders = {
  HomeScreen.routeName: (context, arguments) => const HomeScreen(),
  SplashScreen.routeName: (context, arguments) => const SplashScreen(),
  OnboardingScreen.routeName: (context, arguments) => const OnboardingScreen(),
  LoginScreen.routeName: (context, arguments) => const LoginScreen(),
  SignUpScreen.routeName: (context, arguments) => const SignUpScreen(),
  BottomNavScreen.routeName: (context, arguments) => const BottomNavScreen(),
  ProfileScreen.routeName: (context, arguments) => const ProfileScreen(),
  AnalyiticsScreen.routeName: (context, arguments) => const AnalyiticsScreen(),
};

// Route Generator باستخدام الخريطة
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget Function(BuildContext, dynamic)? builder =
        routeBuilders[settings.name];

    if (builder != null) {
      // تمرير الـ arguments إذا كانت موجودة
      final route =
          Platform.isIOS || Platform.isMacOS
              ? MaterialWithModalsPageRoute(
                builder:
                    (context) => Builder(
                      builder: (context) {
                        return builder(context, settings.arguments);
                      },
                    ),
                settings: settings,
              )
              : MaterialPageRoute(
                builder:
                    (context) => Builder(
                      builder: (context) {
                        return builder(context, settings.arguments);
                      },
                    ),
                settings: settings,
              );

      lastVisitedPage = settings.name;
      return route;
    } else {
      // صفحة افتراضية إذا لم يتم العثور على الـ Route

      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
      );
    }
  }
}

class CustomRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    lastVisitedPage = route.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    lastVisitedPage = previousRoute?.settings.name;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    lastVisitedPage = newRoute?.settings.name;
  }
}
