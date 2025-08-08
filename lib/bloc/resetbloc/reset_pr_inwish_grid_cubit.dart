import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_pr_inwish_grid_state.dart';

class ResetPrInwishGridCubit extends Cubit<ResetPrInwishGridState> {
  ResetPrInwishGridCubit() : super(ResetPrInwishGridInitial());
  void reset() {
    emit(ResetPrInwishGridInitial());
  }
}
