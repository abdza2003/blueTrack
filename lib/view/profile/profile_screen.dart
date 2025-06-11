// lib/view/profile/profile_screen.dart
import 'package:bluetrack/core/components/blue_and_mqtt_config_bottm_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bluetrack/core/components/build_custom_edit_card.dart';
import 'package:bluetrack/core/components/build_custom_tile.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/util/adaptive_icons.dart';
import 'package:bluetrack/controller/device/device_controller.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/view/auth/login_screen.dart';
import 'package:bluetrack/view/profile/components/build_discount_and_copouns_section.dart';
import 'package:bluetrack/view/profile/components/build_profile_cover_and_picture_section.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bluetrack/view/pages/activity_monitor_page.dart';
import 'package:bluetrack/view/mqtt/mqttConfigPage.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile_route';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScaffold(
      title: 'Profile',
      child: SingleChildScrollView(
        controller:
            Provider.of<LayoutController>(
              context,
              listen: false,
            ).scrollControllers[3],
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SpaceConstant.instance.heightSmall,
            _buildProfileHeader(context),
            SpaceConstant.instance.heightXSmall,
            _buildCustomCard(
              context: context,
              index: 2,
              tiles: [
                _buildCustomListTile(
                  title: 'Home Page',
                  svgIcon: ImageConstant.instance.house,
                  isSvgIcon: false,
                  onTap: () {
                    Provider.of<LayoutController>(
                      context,
                      listen: false,
                    ).bottomNavTabFunc(0, navigatorToMainPage: true);
                  },
                ),
                _buildCustomListTile(
                  title: 'Analytics',
                  svgIcon: ImageConstant.instance.graph,
                  isSvgIcon: false,
                  onTap: () {
                    Provider.of<LayoutController>(
                      context,
                      listen: false,
                    ).bottomNavTabFunc(1, navigatorToMainPage: true);
                  },
                ),
                _buildCustomListTile(
                  title: 'Bluetooth',
                  svgIcon: ImageConstant.instance.bluetooth,
                  isSvgIcon: false,
                  onTap:
                      () async =>
                          await blueConfigConfigBottomSheetPage(context),
                ),
                _buildCustomListTile(
                  title: 'MQTT Config',
                  svgIcon: ImageConstant.instance.cloudWifi2,
                  isSvgIcon: false,
                  onTap: () async => await mqttConfigBottomSheetPage(context),
                ),
              ],
            ),
            SpaceConstant.instance.heightXSmall,
            _buildThemeCard(context),
            SpaceConstant.instance.heightXSmall,
            _buildAboutCard(context),
            SpaceConstant.instance.heightXSmall,
            _buildLoginCard(context),
            SpaceConstant.instance.heightXXXLarge,
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCard({
    required BuildContext context,
    required List<Widget> tiles,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: BuildCustomEditCard(tiles: tiles, index: index),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: const BuildProfileCoverAndPictureSection(),
    );
  }

  Widget _buildThemeCard(BuildContext context) {
    return _buildCustomCard(
      index: 2,
      context: context,
      tiles: [
        Selector<DeviceController, ThemeMode>(
          selector: (context, controller) => controller.themeMode,
          builder: (context, themeMode, _) {
            return _buildCustomListTile(
              title: 'Dark Mode',
              leadingIcon: getIconBasedOnPlatform(
                CupertinoIcons.moon_stars,
                Icons.dark_mode,
              ),
              trailing: Switch.adaptive(
                activeColor: CupertinoColors.activeGreen,
                value: themeMode == ThemeMode.dark,
                onChanged: (val) {
                  context.read<DeviceController>().setThemeMode(context);
                },
              ),
              onTap: () {
                context.read<DeviceController>().setThemeMode(context);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return _buildCustomCard(
      index: 2,
      context: context,
      tiles: [
        _buildCustomListTile(
          title: 'About us',
          leadingIcon: getIconBasedOnPlatform(
            CupertinoIcons.info,
            Icons.info_outline,
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return _buildCustomCard(
      index: 2,
      context: context,
      tiles: [
        _buildCustomListTile(
          title: 'Login',
          leadingIcon: getIconBasedOnPlatform(
            CupertinoIcons.square_arrow_right,
            Icons.logout,
          ),
          onTap: () async {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          },
        ),
      ],
    );
  }

  Widget _buildCustomListTile({
    required String title,
    IconData? leadingIcon,
    Widget? trailing,
    bool? isLoading,
    String? svgIcon,
    bool isSvgIcon = true,
    required Function()? onTap,
  }) {
    return BuildCustomTile(
      icon:
          isLoading == true
              ? const CupertinoActivityIndicator()
              : (svgIcon == null || svgIcon == '')
              ? null
              : isSvgIcon
              ? SvgPicture.asset(svgIcon, width: 20.r, height: 20.r)
              : Image.asset(svgIcon, width: 20.r, height: 20.r),
      trailing: trailing,
      title: title,
      leadingIcon: leadingIcon,
      onTap: onTap,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
