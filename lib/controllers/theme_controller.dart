import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whatsapp_clone/res/colors.dart';

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeController() : super(ThemeMode.light);

  ThemeMode get themeMode => _themeMode;

  void switchThemeMode(ThemeMode mode) {
    _themeMode = mode;
    state = mode;
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
  }

  static const _textTheme = TextTheme(
    titleMedium: TextStyle(overflow: TextOverflow.ellipsis),
    bodyLarge: TextStyle(overflow: TextOverflow.ellipsis),
    bodyMedium: TextStyle(fontSize: 16),
    titleLarge: TextStyle(color: kWhiteColor),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      splashColor: kDefaultSplashColor,
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: kLightDarkGrey, size: 26),
      colorScheme: const ColorScheme.light(
        onSecondary: kWhiteColor,
        onPrimary: kWhiteColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor:
            Color.fromARGB(255, 18, 140, 127), // WhatsApp green color
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      textTheme: _textTheme,
      colorScheme: const ColorScheme.dark(
        primary: kDarkPrimaryColor,
        secondary: kDarkSecondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor:
            Color.fromARGB(255, 18, 140, 127), // WhatsApp green color
      ),
    );
  }
}
