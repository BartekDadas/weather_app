import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/const.dart';
import 'package:weather_app/widgets/weather_info.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/location_permission_handler.dart';
import '../widgets/city_search_bar.dart';
import '../widgets/favorites_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(Constants.title,
            style: TextStyle(fontWeight: FontWeight.w600,),),
        actions: [
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (weather, favorites) {
                  final isFavorite = favorites.contains(weather.cityName);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        context
                            .read<WeatherCubit>()
                            .removeFromFavorites(weather.cityName);
                      } else {
                        context
                            .read<WeatherCubit>()
                            .addToFavorites(weather.cityName);
                      }
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.white),
            onPressed: () => _showThemeDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<WeatherCubit>().getCurrentLocationWeather();
            },
          ),
        ],
      ),
      drawer: const FavoritesDrawer(),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1a1a2e)
                      : const Color(0xFF4a90e2),
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF16213e)
                      : const Color(0xFF87ceeb),
                ],
              ),
            ),
            child: Column(
              children: [
                if (state.maybeWhen(
                  loaded: (_, __) => true,
                  orElse: () => false,
                ))
                  const Padding(
                    padding: EdgeInsets.only(top: 100, left: 16, right: 16),
                    child: CitySearchBar(),
                  ),
                Expanded(
                  child: LocationPermissionHandler(
                    childBuilder: (state) => state.maybeWhen(
                      loaded: (weather, _) => WeatherInfo(weather: weather),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.changeMode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(Constants.lightMode),
              leading: const Icon(Icons.brightness_5),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.light);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(Constants.darkMode),
              leading: const Icon(Icons.brightness_3),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.dark);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(Constants.autoMode),
              leading: const Icon(Icons.brightness_auto),
              onTap: () {
                context.read<ThemesCubit>().setThemeMode(ThemesMode.auto);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
