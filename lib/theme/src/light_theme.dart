part of 'theme.dart';

ThemeData get lightTheme {
  return ThemeData(
    // useMaterial3: true,
    // primaryColor: AppColors.fairyTale,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.pink,
      onPrimary: AppColors.lightGray,
      secondary: AppColors.lightGray,
      onSecondary: AppColors.black,
      error: AppColors.blue,

      onError: AppColors.blue,

      surface: AppColors.lightGray,
      onSurface: AppColors.black,
      tertiary: AppColors.darkGray,
    ),
    scaffoldBackgroundColor: AppColors.white,
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.black),
  );
}
