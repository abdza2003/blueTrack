import 'package:bluetrack/core/components/build_custom_edit_card.dart';
import 'package:bluetrack/view/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bluetrack/controller/device/device_controller.dart';
import 'package:bluetrack/controller/layout/layout_controller.dart';
import 'package:bluetrack/core/components/adaptive_dialog_action.dart';
import 'package:bluetrack/core/components/build_custom_tile.dart';
import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/util/adaptive_icons.dart';
import 'package:bluetrack/view/profile/components/build_discount_and_copouns_section.dart';
import 'package:bluetrack/view/profile/components/build_profile_cover_and_picture_section.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile_route';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

//todo AutomaticKeepAliveClientMixin : يتم استخدامها لكي لا يتم عمل initilazion للصفحة في كل مرة

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //todo : تابعة ل دالة ال  AutomaticKeepAliveClientMixin
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
            // SpaceConstant.instance.heightSmall,
            // _buildCustomCard(
            //   context: context,
            //   tiles: [_buildWhatsappAdTile(context)],
            //   index: 0,
            // ),
            // SpaceConstant.instance.heightXSmall,
            // _buildCouponAndDiscountSection(context),
            SpaceConstant.instance.heightXSmall,
            // _buildCustomCard(
            //   context: context,
            //   tiles: [
            //     _buildCustomListTile(
            //       title: 'my_order',
            //       svgIcon: ImageConstant.instance.carSvg,
            //       onTap: () {
            //         Navigator.pushNamed(context, MyOrderScreen.routeName);
            //       },
            //     ),
            //     _buildCustomListTile(
            //       title: 'my_favorite',
            //       svgIcon: ImageConstant.instance.favoriteSvg,
            //       onTap: () {
            //         Provider.of<LayoutController>(context, listen: false)
            //             .bottomNavTabFunc(2, navigatorToMainPage: true);
            //       },
            //     ),
            //     _buildCustomListTile(
            //       title: 'my_basket',
            //       svgIcon: ImageConstant.instance.cardSvg,
            //       onTap: () {
            //         Provider.of<LayoutController>(context, listen: false)
            //             .bottomNavTabFunc(1, navigatorToMainPage: true);
            //       },
            //     ),
            //     _buildCustomListTile(
            //         title: 'my_addreses',
            //         svgIcon: ImageConstant.instance.adresesSvg,
            //         onTap: () {
            //           Navigator.pushNamed(
            //               context, ViewAllUserAddressesScreen.routeName);
            //         }),
            //     _buildCustomListTile(
            //       title: 'currencies',
            //       isSvgIcon: false,
            //       svgIcon: ImageConstant.instance.currencies,
            //       onTap: () => currenciesSection(context),
            //     ),
            //   ],
            //   index: 2,
            // ),
            SpaceConstant.instance.heightXSmall,
            _buildCustomCard(
              context: context,
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
                  onTap: () {},
                ),
              ],
              index: 2,
            ),
            SpaceConstant.instance.heightXSmall,
            _buildAdditionalOptions(context),
            SpaceConstant.instance.heightXSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCustomCard(
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
                ),
              ],
            ),
            SpaceConstant.instance.heightXSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCustomCard(
                  index: 2,
                  context: context,
                  tiles: [
                    _buildCustomListTile(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                      title: 'Login',
                      leadingIcon: getIconBasedOnPlatform(
                        CupertinoIcons.square_arrow_right,
                        Icons.logout,
                      ),
                      onTap: () async {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SpaceConstant.instance.heightXXXLarge,
            SpaceConstant.instance.heightXXXLarge,
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCustomCard(
          index: 2,
          context: context,
          tiles: [_buildThemeModeTile(context)],
        ),
      ],
    );
  }

  void languagesSection(BuildContext context) {
    showCupertinoModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: context.onBackground,
      context: context,
      builder: (context) => Container(),
    );
  }

  void currenciesSection(BuildContext context) {
    showCupertinoModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: context.onBackground,
      context: context,
      builder: (context) => Container(),
    );
  }

  void addressSection(BuildContext context) {
    showCupertinoModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) => Container(),
    ).whenComplete(() {});
  }

  Widget _buildThemeModeTile(BuildContext context) {
    return Selector<DeviceController, ThemeMode>(
      builder: (context, themeMode, _) {
        return _buildCustomListTile(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          trailing: Switch.adaptive(
            activeColor: CupertinoColors.activeGreen,
            value: themeMode == ThemeMode.dark,
            onChanged: (val) {
              context.read<DeviceController>().setThemeMode(context);
            },
          ),
          title: 'Dark Mode',
          leadingIcon: getIconBasedOnPlatform(
            CupertinoIcons.moon_stars,
            Icons.dark_mode,
          ),
          onTap: () {
            context.read<DeviceController>().setThemeMode(context);
          },
        );
      },
      selector: (context, controller) => controller.themeMode,
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
    BorderRadiusGeometry? borderRadius,
  }) {
    return BuildCustomTile(
      icon:
          isLoading == true
              ? const CupertinoActivityIndicator()
              : svgIcon == '' || svgIcon == null
              ? null
              : isSvgIcon
              ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(svgIcon, width: 20.r, height: 20.r),
              )
              : SizedBox(
                width: 20.r,
                height: 20.r,
                child: Image.asset(svgIcon, width: 20.r, height: 20.r),
              ),
      trailing: trailing,
      title: title,
      leadingIcon: leadingIcon,
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  // Profile Header with Avatar and Name
  Widget _buildProfileHeader(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: const BuildProfileCoverAndPictureSection(),
    );
  }

  // Gradient Card
  Widget _buildGradientCard(
    BuildContext context,
    String imagePath,
    String text,
  ) {
    return BuildDiscountAndCopunsSection(imagePath: imagePath, text: text);
  }

  //todo : تابعة ل دالة ال  AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;
}

// Custom Card
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
