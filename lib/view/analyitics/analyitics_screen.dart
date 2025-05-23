import 'package:bluetrack/core/components/build_custom_edit_card.dart';
import 'package:bluetrack/core/components/emty_list.dart';
import 'package:bluetrack/core/constants/padding_and_margin_constant.dart';
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

class AnalyiticsScreen extends StatefulWidget {
  static const String routeName = 'Analyitics_route';
  const AnalyiticsScreen({super.key});

  @override
  State<AnalyiticsScreen> createState() => _ProfileScreenState();
}

//todo AutomaticKeepAliveClientMixin : يتم استخدامها لكي لا يتم عمل initilazion للصفحة في كل مرة

class _ProfileScreenState extends State<AnalyiticsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //todo : تابعة ل دالة ال  AutomaticKeepAliveClientMixin
    return CustomScaffold(
      title: 'Analyitics',
      child: SingleChildScrollView(
        controller:
            Provider.of<LayoutController>(
              context,
              listen: false,
            ).scrollControllers[2],
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: PaddingAndMarginConstant.instance.symmetricHorizontalMedium,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpaceConstant.instance.heightXLarge,
              CustomEmptyList(
                text:
                    'No analytics available at the moment. Data will be displayed here once it becomes available',
                assetImage: ImageConstant.instance.analyitics,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
