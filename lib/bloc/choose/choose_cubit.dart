import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_state.dart';

class ChooseCubit extends Cubit<ChooseState> {
  ChooseCubit() : super(ChooseWomen());

  void women() {
    emit(ChooseWomen());
  }

  void men() {
    emit(ChooseMen());
  }
}
