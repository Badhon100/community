import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension MediaQueryExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

extension NavigatorExt on BuildContext {
  Future<T?> push<T>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

extension ScaffoldExt on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger =>
      ScaffoldMessenger.of(this);

  void showSnackBar(SnackBar snackBar) {
    scaffoldMessenger.showSnackBar(snackBar);
  }
}

