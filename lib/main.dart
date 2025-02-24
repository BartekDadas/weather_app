import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/utils/const.dart';
import 'config/di.dart';
import 'screens/main_screen.dart';
import 'cubits/weather_cubit.dart';
import 'cubits/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherCubit = getIt.get<WeatherCubit>();
    final themesCubit = getIt.get<ThemesCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (_) => weatherCubit,
        ),
        BlocProvider<ThemesCubit>(
          create: (_) => themesCubit,
        ),
      ],
      child: BlocBuilder<ThemesCubit, ThemesMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: Constants.title,
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: themeMode == ThemesMode.auto ? ThemeMode.system : themeMode == ThemesMode.light ? ThemeMode.light : ThemeMode.dark,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
