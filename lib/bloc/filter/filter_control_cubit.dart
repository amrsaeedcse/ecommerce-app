import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FilterControlCubit extends Cubit<FilterType> {
  FilterControlCubit() : super(FilterType.None);
  void makeLowToHigh() {
    emit(FilterType.Lowest_HighestPrice);
  }

  void makeHighToLow() {
    emit(FilterType.Highest_LowestPrice);
  }

  void reset() {
    emit(FilterType.None);
  }
}

enum FilterType {
  None,
  Recommended,
  Newest,
  Lowest_HighestPrice,
  Highest_LowestPrice,
}
