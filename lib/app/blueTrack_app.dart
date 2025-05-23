import 'package:bluetrack/controller/device/device_controller.dart';
import 'package:bluetrack/core/theme/theme.dart';
import 'package:bluetrack/route_generate.dart';
import 'package:bluetrack/view/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BlueTrackApp extends StatefulWidget {
  const BlueTrackApp._internal();
  static const BlueTrackApp _instance = BlueTrackApp._internal();
  factory BlueTrackApp() => _instance;

  @override
  State<BlueTrackApp> createState() => _BlueTrackAppState();
  // ignore: library_private_types_in_public_api
  static _BlueTrackAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BlueTrackAppState>();
}

class _BlueTrackAppState extends State<BlueTrackApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Selector<DeviceController, ThemeMode>(
      builder: (context, deviceInfo, _) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: CustomTheme().buildThemeData(context),
              darkTheme: CustomTheme().buildThemeDataDark(context),
              themeMode: deviceInfo,
              // themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: SplashScreen.routeName,
              navigatorObservers: [
                CustomRouteObserver(),
              ], // أضف الـ Observer هنا
              // home: BluetoothScreen(),
              // home: const ProductDetailsScreen(
              //   variantId: 62,
              //   hashId: 'a1ybZy05',
              // ),
            );
          },
        );
      },
      selector: (p0, p1) => p1.themeMode,
    );
  }
}

//
