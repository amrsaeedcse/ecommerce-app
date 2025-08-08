import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ProductChooseColorCubit extends Cubit<Color> {
  ProductChooseColorCubit() : super(Colors.red);
  void putColor(Color color) {
    emit(color);
  }

  void reset() {
    emit(Colors.red);
  }
}
