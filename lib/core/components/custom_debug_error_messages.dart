// ويدجت لعرض الخطأ بشكل لطيف
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/space_constant.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, this.errorMessage = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 45.0.r),
            SpaceConstant.instance.heightXXSmall,
            Txt(
              text: 'Error Occurred!',
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
            SpaceConstant.instance.heightXSmall,
            Txt(
              text: errorMessage,
              textAlign: TextAlign.center,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ويدجت لإظهار الخطأ باستخدام CustomErrorWidget
class ErrorWidgetClass extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorWidgetClass(this.errorDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomErrorWidget(errorMessage: errorDetails.exceptionAsString()),
    );
  }
}
