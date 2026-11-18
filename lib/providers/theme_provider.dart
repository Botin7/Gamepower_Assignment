import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = const Color(0xFF6750A4);

  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setDarkMode(bool enabled) {
    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSeedColor(Color color) {
    _seedColor = color;
    notifyListeners();
  }
}
