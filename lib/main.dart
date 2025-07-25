import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/desire_bloc.dart';
import 'package:flutter_projects/router/router.dart';
import 'package:flutter_projects/theme/src/theme.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'models/desire.dart';
import 'theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DesireAdapter());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(SetInitialTheme())),
        BlocProvider(create: (context) => DesireBloc()..add(LoadDesireList())),
      ],
      child: const DesireList(),
    ),
  );
}

class DesireList extends StatefulWidget {
  const DesireList({super.key});

  @override
  State<DesireList> createState() => _DesireListState();
}

class _DesireListState extends State<DesireList> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          theme: AppTheme.light, // Светлая тема
          darkTheme: AppTheme.dark, // Темная тема
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
