import 'package:admin_panal/widget/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false; // Default to light mode

  bool get isDarkMode => _isDarkMode;

  // Constructor to load the saved theme from SharedPreferences
  ThemeProvider() {
    _loadTheme();
  }

  // Load the saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  // Toggle dark mode
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners(); // Notify listeners when the theme changes
  }

  // Define light and dark theme colors here
  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: themeblue,
      scaffoldBackgroundColor: themelight,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF01949a)),
      iconTheme: const IconThemeData(color: Colors.black), // Define icon color
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white), // Light mode text color
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF01949a),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF01949a)),
      iconTheme: const IconThemeData(color: Colors.white), // Define icon color
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    );
  }

  // Get the current theme based on dark mode status
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
}
