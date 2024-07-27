import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String message,
    Color? textColor = AppColors.bgLight,
    Color? backgroundColor = AppColors.appPrimaryColor}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3000),
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Colors.yellow,
      onPressed: () {
        // Dismiss Snackbar
        scaffoldMessenger.hideCurrentSnackBar();
      },
    ),
  );
  scaffoldMessenger.showSnackBar(snackBar);
}

void showSuccessMessage(BuildContext context, String message) {
  showSnackBar(
      message: message,
      textColor: AppColors.bgLight,
      backgroundColor: AppColors.success,
      context: context);
}

void showInfoMessage(BuildContext context, String message) {
  showSnackBar(
      message: message,
      textColor: AppColors.bgLight,
      backgroundColor: AppColors.primary,
      context: context);
}

void showErrorMessage(BuildContext context, String message) {
  showSnackBar(
      message: message,
      textColor: AppColors.bgLight,
      backgroundColor: AppColors.error,
      context: context);
}
