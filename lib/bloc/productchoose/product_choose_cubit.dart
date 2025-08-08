import 'package:bloc/bloc.dart';

class ProductChooseSizeCubit extends Cubit<ProductSize> {
  ProductChooseSizeCubit() : super(ProductSize.S);
  void putSize(ProductSize size) {
    emit(size);
  }

  void reset() {
    emit(ProductSize.S);
  }
}

enum ProductSize { S, M, Xl, Xl2 }
