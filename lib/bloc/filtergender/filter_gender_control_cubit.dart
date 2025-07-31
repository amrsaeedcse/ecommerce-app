import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FilterGenderControlCubit extends Cubit<FilterGenderType> {
  FilterGenderControlCubit() : super(FilterGenderType.None);

  void makeItMen() {
    emit(FilterGenderType.Men);
  }

  void makeItWomen() {
    emit(FilterGenderType.Women);
  }
}

enum FilterGenderType { None, Men, Women, Kids }
