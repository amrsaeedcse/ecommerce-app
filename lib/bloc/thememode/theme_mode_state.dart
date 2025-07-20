part of 'theme_mode_cubit.dart';

@immutable
sealed class ThemeModeState {}

final class ThemeModeLight extends ThemeModeState {}

final class ThemeModeDark extends ThemeModeState {}
