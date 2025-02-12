// import 'package:flutter/material.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   ThemeData _currentTheme = ThemeData.light();
//
//   ThemeData get currentTheme => _currentTheme;
//
//   void toggleTheme() {
//     _currentTheme = _currentTheme == ThemeData.light()
//         ? ThemeData.dark()
//         : ThemeData.light();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = _lightTheme; // Default: Light Theme

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white, // ✅ Background Pure White
    primaryColor: Colors.blue, // ✅ Primary Theme Color
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      background: Colors.white, // ✅ Background White
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white, // ✅ White AppBar
      foregroundColor: Colors.black, // ✅ Black Text/Icon
      elevation: 0, // ✅ No Shadow
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // ✅ Black Text
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black, // ✅ Dark Mode Background
    primaryColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey,
      secondary: Colors.blueAccent,
      background: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // ✅ White Text
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
