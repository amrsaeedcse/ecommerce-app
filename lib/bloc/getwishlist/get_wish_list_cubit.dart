import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'get_wish_list_state.dart';

class GetWishListCubit extends Cubit<GetWishListState> {
  GetWishListCubit() : super(GetWishListLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future getWishList() async {
    try {
      emit(GetWishListLoading());
      final List<ProductModel> productModels = await fireBaseFireStore
          .getWishList();
      emit(GetWishListSuccess(productModels));
    } catch (e) {
      if (e.toString().contains("empty")) {
        emit(GetWishListEmpty());
      } else {
        emit(GetWishListFailure());
      }
    }
  }
}
