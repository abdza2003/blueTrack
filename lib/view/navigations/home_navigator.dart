import 'package:flutter/material.dart';
import 'package:bluetrack/route_generate.dart';
import 'package:bluetrack/view/home/home_screen.dart';
import 'package:provider/provider.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  HomeNavigatorState createState() => HomeNavigatorState();
}

GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: HomeScreen.routeName,
      key: homeNavigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      observers: [CustomRouteObserver()], // ملاحظة: لكل Navigator
    );
  }
}
