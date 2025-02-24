import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit.dart';

class FavoritesDrawer extends StatelessWidget {
  const FavoritesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final favorites = state.favoriteLocations;

          return Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                  child: Text(
                    'Favorite Locations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (favorites.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No favorite locations yet',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final location = favorites[index];
                      return ListTile(
                        title: Text(location),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<WeatherCubit>().removeFromFavorites(location);
                          },
                        ),
                        onTap: () {
                          context.read<WeatherCubit>().getWeatherByCity(location);
                          Navigator.pop(context); // Close drawer
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
