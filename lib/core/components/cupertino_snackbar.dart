// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hypermart/core/components/txt.dart';

// class CupertinoSnackBar {
//   void showCupertinoSnackBar(BuildContext context,
//       {String? title,
//       required String message,
//       required IconData icon,
//       int milliseconds = 2200,
//       required Color color}) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => CupertinoActionSheet(
        
//         title: title != null ? Text(title) : null,
//         message: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: color, // تخصيص اللون بناءً على الحالة
//               radius: 4 * pi,
//               child: Padding(
//                 padding: EdgeInsets.all(1.r),
//                 child: Icon(
//                   icon, // تخصيص الأيقونة بناءً على الحالة
//                   color: CupertinoColors.white,
//                   size: 17.r,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//             Expanded(
//               child: Txt(
//                 text: message,
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     // إغلاقه بعد ثانيتين
//     Future.delayed(Duration(milliseconds: milliseconds), () {
//       if (Navigator.canPop(context)) {
//         Navigator.pop(context); // إغلاق الـ CupertinoActionSheet مع أنيميشن
//       }
//     });
//   }

//   static void showErrorSnackBar(
//     BuildContext context, {
//     String? title,
//     required String message,
//     int milliseconds = 2200,
//   }) {
//     CupertinoSnackBar().showCupertinoSnackBar(
//       context,
//       title: title,
//       message: message,
//       milliseconds: milliseconds,
//       icon: CupertinoIcons.clear_circled,
//       color: CupertinoColors.systemRed, // اللون الأحمر لرسائل الأخطاء
//     );
//   }

//   static void showSuccessSnackBar(BuildContext context,
//       {String? title, required String message, int milliseconds = 2200}) {
//     CupertinoSnackBar().showCupertinoSnackBar(
//       context,
//       title: title,
//       message: message,
//       milliseconds: milliseconds,

//       icon: CupertinoIcons.check_mark_circled,
//       color: CupertinoColors.activeGreen, // اللون الأخضر لرسائل النجاح
//     );
//   }
// }
