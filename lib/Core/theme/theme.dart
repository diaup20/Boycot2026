import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.light(
    primary: kPrimaryColor,
    secondary: Colors.white,
    onSurface: Colors.grey.shade600,
    onBackground: Colors.black87,
    primaryContainer: Colors.white,
    secondaryContainer: Color(0xFFf5fafd),
    shadow: const Color(0xfff8f8f8),
  ),
  splashColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  cardTheme: const CardTheme(color: Colors.white),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: kPrimaryColor.withOpacity(0.4),
    selectionHandleColor: kPrimaryColor,
    cursorColor: kPrimaryColor,
  ),
  textTheme: TextTheme(
    bodyLarge:
        TextStyle(color: Colors.black87, fontSize: 18, fontFamily: 'Cairo'),
    bodyMedium: TextStyle(color: Colors.black54, fontFamily: 'Cairo'),
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Colors.white),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFFE3E0DF),
  ),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kPrimaryColor),
  shadowColor:     kPrimaryColor.withOpacity(0.09),

  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      color: kPrimaryColor, 
      borderRadius: BorderRadius.circular(12),
    ),
    dividerColor: kPrimaryColor,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Colors.white70,
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.dark(
    primary: Colors.white70,
    secondary: kPrimaryColor,
    onBackground: Colors.white70,
    onSurface: Colors.grey.shade400,
    secondaryContainer: const Color(0xff16202A),
    primaryContainer: const Color(0xff1C2939),
    shadow: const Color(0x3F000000),
  ),
  splashColor: const Color(0xff16202A),
  scaffoldBackgroundColor: const Color(0xff16202A),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff16202A),
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo'),
  ),
  cardTheme: const CardTheme(color: Color(0xff16202A)),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: kPrimaryColor.withOpacity(0.4),
    selectionHandleColor: kPrimaryColor,
    cursorColor: kPrimaryColor,
  ),
  textTheme: TextTheme(
    bodyLarge:
        TextStyle(color: Colors.white70, fontSize: 18, fontFamily: 'Cairo'),
    bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Cairo'),
  ),
  iconTheme: const IconThemeData(color: kPrimaryColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff16202A),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xff16202A),
  ),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xff1C2939)),
  tabBarTheme: TabBarTheme(
    indicatorColor: Colors.white70,
    dividerColor: Colors.white70,
    indicator: BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  
  shadowColor: const Color(0x1E49454F),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Colors.white70,
      ),
    ),
  ),
);
