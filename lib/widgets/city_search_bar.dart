import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit.dart';
import '../models/city_suggestion.dart';

class CitySearchBar extends StatefulWidget {
  const CitySearchBar({super.key});

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends State<CitySearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _showSuggestions = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) async {
    setState(() => _showSuggestions = true);
    await context.read<WeatherCubit>().updateCitySuggestions(value);
  }

  void _onCitySelected(CitySuggestion suggestion) {
    _controller.text = suggestion.name;
    context.read<WeatherCubit>().getWeatherByLocation(
          suggestion.lat,
          suggestion.lon,
        );
    setState(() => _showSuggestions = false);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search city...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _focusNode.unfocus();
                  setState(() => _showSuggestions = false);
                  context.read<WeatherCubit>().updateCitySuggestions('');
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
          ),
          if (_showSuggestions)
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                final suggestions = context.read<WeatherCubit>().currentSuggestions;
                if (suggestions.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          title: Text(suggestion.name),
                          subtitle: Text(
                            [
                              if (suggestion.state != null) suggestion.state,
                              suggestion.country,
                            ].where((e) => e != null).join(', '),
                          ),
                          onTap: () => _onCitySelected(suggestion),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
