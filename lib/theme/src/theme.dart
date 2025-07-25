import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';
part 'text_style_theme.dart';
part 'text_theme.dart';
part 'constants.dart';

class AppTheme {
  static ThemeData get dark => darkTheme;
  static ThemeData get light => lightTheme;
}
