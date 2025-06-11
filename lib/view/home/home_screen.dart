// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/blue_and_mqtt_config_bottm_sheet_page.dart';
import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/enum/font_family_enum.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/extension/font_family_extansion.dart';
import 'package:bluetrack/core/util/blue_services_dialog.dart';
import 'package:bluetrack/core/util/location_services_dialog.dart';
import 'package:bluetrack/view/bluetooth/blue_config_page.dart';
import 'package:bluetrack/view/bluetooth/blue_connection_page.dart';
import 'package:bluetrack/view/home/components/custom_sections_button.dart';
import 'package:bluetrack/view/mqtt/mqttConfigPage.dart';
import 'package:bluetrack/view/pages/activity_monitor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String receivedValue = 'No data received yet';

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppbar: false,
      title: 'Home Page',

      child: SafeArea(
        child: Column(
          children: [
            SpaceConstant.instance.heightXSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Home Screen',

                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    family: FontFamilyEnum.enSora.rawValue,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(0.0),
                    minSize: 0.0,
                    onPressed: () {
                      Provider.of<LayoutController>(
                        context,
                        listen: false,
                      ).bottomNavTabFunc(2, navigatorToMainPage: true);
                    },
                    child: CircleAvatar(
                      radius: 8 * pi,
                      backgroundColor: ColorConstants.instance.primary
                          .withOpacity(.2),
                      child: CircleAvatar(
                        radius: 6 * pi,
                        backgroundColor: ColorConstants.instance.primary
                            .withOpacity(.6),
                        child: Icon(CupertinoIcons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SpaceConstant.instance.heightSmall,
            SizedBox(
              height: 150.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSectionsCardButton(
                        title: 'MQTT Config',
                        iconPath: ImageConstant.instance.cloudWifi1,
                        color: ColorConstants.instance.primary.withOpacity(.9),
                        // onTap: () async {
                        //   final result = await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (_) => const MqttConfigPage(),
                        //     ),
                        //   );
                        // if (result != null && result is Map) {
                        //   final broker = result['broker'];
                        //   final topic = result['topic'];
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder:
                        //           (_) => ActivityMonitorPage(
                        //             broker: broker,
                        //             topic: topic,
                        //           ),
                        //     ),
                        //   );
                        // }
                        // },
                        onTap:
                            () async =>
                                await mqttConfigBottomSheetPage(context),
                      ),
                    ),
                    SpaceConstant.instance.widthXSmall,
                    Expanded(
                      child: CustomSectionsCardButton(
                        title: 'Bluetooth',
                        color: CupertinoColors.systemBlue.withOpacity(.9),

                        iconPath: ImageConstant.instance.bluetooth1,
                        // onTap: _startScanAndShowDialog,
                        onTap:
                            () async =>
                                await blueConfigConfigBottomSheetPage(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SpaceConstant.instance.heightXXXLarge,
            SpaceConstant.instance.heightXXXLarge,
            // ElevatedButton(
            //   onPressed: _startScanAndShowDialog,
            //   child: Txt(text: 'Search Devices', color: Colors.white),
            // ),
            // SpaceConstant.instance.heightMedium,
            // Txt(
            //   text: 'Received Values',
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.bold,
            // ),
            // SpaceConstant.instance.heightXSmall,
            // Txt(text: receivedValue, fontSize: 12.sp),
          ],
        ),
      ),
    );
  }
}
