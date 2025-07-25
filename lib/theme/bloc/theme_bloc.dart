import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDark: false)) {
    // execute this event when the app starts
    on<SetInitialTheme>((event, emit) async {
      bool hasThemeDark = await isDark();
      emit(ThemeState(isDark: hasThemeDark));
    });

    // toggle the app theme
    on<ChangeTheme>((event, emit) async {
      final hasThemeDark = state.isDark;
      final newTheme = !hasThemeDark;
      await setTheme(newTheme);
      emit(ThemeState(isDark: newTheme));
    });
  }
}

Future<bool> isDark() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getBool('isDark') ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sharedPreferences.setBool('isDark', isDark);
}
