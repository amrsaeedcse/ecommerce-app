import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'get_cart_control_state.dart';

class GetCartControlCubit extends Cubit<GetCartControlState> {
  GetCartControlCubit() : super(GetCartControlLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  Future getCart() async {
    try {
      emit(GetCartControlLoading());
      List<CartModel> cartModels = await fireBaseFireStore.getCart();
      emit(GetCartControlSuccess(cartModels));
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("no carts")) {
        emit(GetCartControlEmpty());
      } else {
        emit(GetCartControlFailure());
      }
    }
  }
}
