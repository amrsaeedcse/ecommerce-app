import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'age_control_state.dart';

class AgeControlCubit extends Cubit<AgeControlState> {
  AgeControlCubit() : super(AgeControlInitial());

  void setValue(String age) {
    emit(AgeControlValue(age));
  }
}
