import 'dart:io';
import 'package:bluetrack/app/blueTrack_app.dart';
import 'package:bluetrack/controller/device/device_controller.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Directory? tempDir;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await SPManager.instance.startingCache();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  //? تهيئة التعامل مع الإشعارات
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //? طلب الإذن (لـ iOS فقط)
  // await messaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  //? الاستماع للنقر على الإشعار
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print("تم النقر على الإشعار: ${message.notification?.title}");
  //   //todo:  هنا يمكنك إضافة منطق لفتح صفحة أو تنفيذ إجراء بناءً على الإشعار
  // });

  runApp(setRunApp());
}

MultiProvider setRunApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LayoutController(), lazy: true),
      ChangeNotifierProvider(create: (_) => DeviceController(), lazy: true),
    ],
    //todo : Phoenix يتم استخدامها ل انشاء reset للتطبيق
    //? يتم استخدامها في حال كنت اريد اعادة تشغيل التطبيق من جديد في حال اريد تحميل مباشر لبعض البيانات التي تم تخذينها في الذاكرة الؤقتة
    child: BlueTrackApp(),
  );
}

//todo : shorebird patch ios  --export-options-plist=./ios/exportOptions.plist

//todo : shorebird release ios --export-options-plist=./ios/exportOptions.plist

//todo : shorebird patch --platforms=ios --export-options-plist=./ios/exportOptions.plist

//todo : shorebird patch ios-preview --export-options-plist=./ios/exportOptions.plist

//todo : shorebird preview  --platforms=ios --export-options-plist=./ios/exportOpti ons.plist
