import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentTheme = prefs.getString('theme') ?? 'system';
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.grey.shade900,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ).headline6,
      ),
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.dark()
          .copyWith(secondary: Colors.blueGrey) // scrolling effect is bluegrey
      //iconTheme: IconThemeData(color: Colors.white),
      );

  static final lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ).headline6,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light().copyWith(
          secondary:
              Colors.blueGrey[100]) //  // scrolling effect is bluegrey[100]
      //iconTheme: IconThemeData(color: Colors.white),
      );
}
