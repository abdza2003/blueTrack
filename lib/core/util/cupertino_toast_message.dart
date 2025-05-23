import 'package:flutter/material.dart';

void showCupertinoCustomSnackBar(BuildContext context, String message) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50,
      left: MediaQuery.of(context).size.width * 0.2,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  // إدخال الـ OverlayEntry إلى الـ Overlay
  overlayState.insert(overlayEntry);

  // إزالة الـ SnackBar بعد فترة زمنية معينة
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
