part of 'theme.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.fairyTale,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.fairyTale,
      onPrimary: AppColors.gunmetal,
      secondary: AppColors.lightBlue,
      onSecondary: AppColors.black,
      error: const Color.fromARGB(255, 255, 0, 85),

      onError: AppColors.fairyTale,

      surface: AppColors.lightBlue,
      onSurface: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.white,
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.black),
  );
}
