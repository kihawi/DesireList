part of 'theme.dart';

ThemeData get darkTheme {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color.fromARGB(255, 0, 0, 0),
      onPrimary: AppColors.gunmetal,
      secondary: AppColors.ultraViolet,
      onSecondary: AppColors.white,
      error: AppColors.fairyTale,

      onError: AppColors.fairyTale,

      surface: AppColors.ultraViolet,
      onSurface: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.gunmetal,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    useMaterial3: true,
  );
}
