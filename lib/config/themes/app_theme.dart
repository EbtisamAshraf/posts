import 'package:flutter/material.dart';
import 'package:posts/core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    ),
  
  );
}
