part of 'theme.dart';

ThemeData get darkTheme {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.pink,
      onPrimary: AppColors.lightGray,
      secondary: AppColors.darkGray,
      onSecondary: AppColors.lightGray,
      error: AppColors.blue,

      onError: AppColors.blue,

      surface: Color(0xFF292929),
      onSurface: AppColors.lime,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),

    useMaterial3: true,
  );
}
