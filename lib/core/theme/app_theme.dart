import 'package:flutter/services.dart';
import 'package:racemate_task/core/theme/text_theme.dart';

import '../../index.dart';
import '../utils/constants.dart';

class AppTheme {
  // TODO:[Change Theme]
  static final lightTheme = ThemeData(
    primaryColor: Constants.mainColor,
    textTheme: textTheme,
    colorScheme: const ColorScheme.light(
      primary: Constants.mainColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Constants.mainColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.secondColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Constants.mainColor,
        side: const BorderSide(
          color: Constants.mainColor,
          width: 0.8,
        ),
        minimumSize: const Size.fromHeight(44),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
  );
}
