import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeLight());

  void light() {
    emit(ThemeModeLight());
  }

  void dark() {
    emit(ThemeModeDark());
  }
}
