import 'package:community/core/widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';

void showAppConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  bool isDestructive = false,
}) {
  showCupertinoDialog(
    context: context,
    builder: (_) => AppConfirmationDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: isDestructive,
      onConfirm: onConfirm,
    ),
  );
}
