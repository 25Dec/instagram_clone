import 'package:flutter/material.dart';

import 'package:instagram_clone/utils/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.mobileBackgroundColor,
  );
}
