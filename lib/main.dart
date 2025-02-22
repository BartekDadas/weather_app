import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/di.dart';
import 'screens/main_screen.dart';
import 'cubits/weather_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<WeatherCubit>()..getCurrentLocationWeather(),
        child: const MainScreen(),
      ),
    );
  }
}
