import 'package:bloc/bloc.dart';

class ProductChooseSizeCubit extends Cubit<ProductSize> {
  ProductChooseSizeCubit() : super(ProductSize.S);
  void putSize(ProductSize size) {
    emit(size);
  }
}

enum ProductSize { S, M, Xl, Xl2 }
