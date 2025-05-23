import 'package:flutter/material.dart';
import 'package:bluetrack/route_generate.dart';
import 'package:bluetrack/view/home/home_screen.dart';

class FavoriteNavigator extends StatefulWidget {
  const FavoriteNavigator({super.key});

  @override
  FavoriteNavigatorState createState() => FavoriteNavigatorState();
}

GlobalKey<NavigatorState> favoriteNavigatorKey = GlobalKey<NavigatorState>();

class FavoriteNavigatorState extends State<FavoriteNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: HomeScreen.routeName,
      key: favoriteNavigatorKey,
      observers: [CustomRouteObserver()], // ملاحظة: لكل Navigator
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
