import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:probitas_app/core/constants/colors.dart';

class Toasts {
  static void showErrorToast(message) async {
    showOverlayNotification(
      (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.top,
      duration: Duration(seconds: 2),
    );
  }

  static void showSuccessToast(message) async {
    showOverlayNotification(
      (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Material(
              color: ProbitasColor.ProbitasSecondary,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.top,
      duration: Duration(seconds: 2),
    );
  }
}
