import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorThemeData with ChangeNotifier {

  final ThemeData _greenTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.greenAccent,
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: const AppBarTheme(color: Colors.green),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white)),
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  bool _isGreen = true;
  static SharedPreferences? _sharedPrefThemeData;

  void switchTheme(bool selected) {
    _isGreen = selected;
    saveSharedPrefObject(selected);
    notifyListeners();
  }

  Future<void> createSharedPrefObject() async {
    _sharedPrefThemeData = await SharedPreferences.getInstance();
  }

  void saveSharedPrefObject(bool value) {
    _sharedPrefThemeData!.setBool("themeData", value);
  }

  void loadSharedPrefObject() {
    _isGreen = _sharedPrefThemeData!.getBool("themeData") ?? true;
  }

  ThemeData get selectedThemeData => _isGreen ? _greenTheme : _darkTheme;

  bool get isGreen => _isGreen;
}
