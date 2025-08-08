import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class NavBarControlCubit extends Cubit<int> {
  NavBarControlCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }

  void reset() {
    emit(0);
  }
}
