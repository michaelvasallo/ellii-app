import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: 'OpenSans',
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF5774FC),
    onPrimary: Colors.white,
    secondary: Color(0xFF5774FC),
    onSecondary: Colors.white,
    tertiary: Color(0xFFFED502),
    onTertiary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceContainer: Color(0xFFF3F5FD),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black87,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      letterSpacing: -1,
    ),
    titleMedium: TextStyle(
      color: Colors.black87,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    titleSmall: TextStyle(
      color: Colors.black87,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black54,
    toolbarHeight: 64,
    elevation: 2,
    scrolledUnderElevation: 2,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.white,
    shadowColor: Colors.black,
    elevation: 16,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(
        allowEnterRouteSnapshotting: false,
      ),
    },
  ),
);
