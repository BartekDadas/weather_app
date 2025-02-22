import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemesMode { light, dark, auto }

class ThemesCubit extends Cubit<ThemesMode> {
  ThemesCubit() : super(ThemesMode.auto);

  void setThemeMode(ThemesMode mode) => emit(mode);
}
