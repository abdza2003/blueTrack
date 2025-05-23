import 'package:bluetrack/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bluetrack/route_generate.dart';
import 'package:bluetrack/view/home/home_screen.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator({super.key});

  @override
  ProfileNavigatorState createState() => ProfileNavigatorState();
}

GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();

class ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: ProfileScreen.routeName,
      key: profileNavigatorKey,
      observers: [CustomRouteObserver()], // ملاحظة: لكل Navigator
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
