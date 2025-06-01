// lib/view/mqtt/mqttConfigPage.dart
import 'package:bluetrack/core/components/auth_custom_button.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/view/auth/components/auth_text_faild.dart';
import 'package:bluetrack/view/pages/activity_monitor_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MqttConfigPage extends StatefulWidget {
  const MqttConfigPage({super.key});

  @override
  State<MqttConfigPage> createState() => _MqttConfigPageState();
}

class _MqttConfigPageState extends State<MqttConfigPage> {
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  @override
  void dispose() {
    _brokerController.dispose();
    _topicController.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  late final FocusNode topicFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    topicFocusNode = FocusNode();
  }

  Future<void> _submitConfig() async {
    final broker = _brokerController.text.trim();
    final topic = _topicController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      await Future.delayed(Duration(milliseconds: 100), () {
        Navigator.pop(context, {'broker': broker, 'topic': topic});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,

        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AppBar(
                // leadingWidth: 20.0,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actionsPadding: EdgeInsets.all(0.0),

                title: Txt(text: 'MQTT Configuration', fontSize: 15.sp),
                // backgroundColor: Colors.purple.shade700,
                centerTitle: false,
                iconTheme: IconThemeData(color: context.inverse),
              ),

              SpaceConstant.instance.heightSmall,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    AuthTextField(
                      validator:
                          (value) =>
                              value!.isEmpty ? 'This field is required' : null,
                      controller: _brokerController,
                      icon: Icon(CupertinoIcons.wifi),
                      textType: TextInputType.emailAddress,

                      label: 'MQTT Broker',
                    ),

                    SpaceConstant.instance.heightSmall,
                    AuthTextField(
                      validator:
                          (value) =>
                              value!.isEmpty ? 'This field is required' : null,
                      controller: _topicController,
                      icon: Icon(CupertinoIcons.cloud),
                      textType: TextInputType.emailAddress,
                      focusNode: topicFocusNode,

                      label: 'MQTT Topic',
                    ),
                  ],
                ),
              ),
              // TextField(
              //   controller: _topicController,
              //   decoration: const InputDecoration(
              //     labelText: 'MQTT Topic',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AuthCustomButton(
                  onTap: () async => await _submitConfig(),
                  text: 'Connect',
                ),
              ),

              // ElevatedButton(
              //   onPressed: _submitConfig,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.purple,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 32,
              //       vertical: 12,
              //     ),
              //   ),
              //   child: const Text('Connect', style: TextStyle(fontSize: 18)),
              // ),
              SizedBox(height: !context.isKeyboardVisible() ? 300.h : 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
