import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'add_cart_control_state.dart';

class AddCartControlCubit extends Cubit<AddCartControlState> {
  AddCartControlCubit() : super(AddCartControlSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future addCart(CartModel cartModel) async {
    try {
      emit(AddCartControlLoading());
      await fireBaseFireStore.addToCart(cartModel);
      emit(AddCartControlSuccess());
    } catch (e) {
      emit(AddCartControlFailure());
    }
  }
}
