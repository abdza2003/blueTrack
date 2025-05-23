import 'package:bluetrack/view/analyitics/analyitics_screen.dart';
import 'package:flutter/material.dart';
import 'package:bluetrack/route_generate.dart';
import 'package:bluetrack/view/home/home_screen.dart';

class CartNavigator extends StatefulWidget {
  const CartNavigator({super.key});

  @override
  CartNavigatorState createState() => CartNavigatorState();
}

GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>();

class CartNavigatorState extends State<CartNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: AnalyiticsScreen.routeName,
      key: cartNavigatorKey,
      observers: [CustomRouteObserver()], // ملاحظة: لكل Navigator
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
