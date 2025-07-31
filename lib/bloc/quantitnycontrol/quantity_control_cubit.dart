import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'quantity_control_state.dart';

class QuantityControlCubit extends Cubit<QuantityControlState> {
  QuantityControlCubit() : super(QuantityControlInitial());

  void add() {
    emit(QuantityControlValue(state.counter + 1));
  }

  void minus() {
    if (state.counter != 1) {
      emit(QuantityControlValue(state.counter - 1));
    }
  }

  void reset() {
    emit(QuantityControlInitial());
  }
}
