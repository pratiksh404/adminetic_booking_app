import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';

class AppToast {
  final BuildContext context;
  final String message;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  GFToastPosition? toastPosition;
  AppToast(
      {required this.context,
      required this.message,
      this.icon = Icons.info_outline,
      this.color = GFColors.LIGHT,
      this.backgroundColor = GFColors.DARK,
      this.toastPosition = GFToastPosition.BOTTOM});

  void call() {
    GFToast.showToast(message, context,
        toastPosition: toastPosition,
        textStyle: TextStyle(fontSize: 16, color: color),
        backgroundColor: backgroundColor,
        trailing: Icon(icon));
  }
}
