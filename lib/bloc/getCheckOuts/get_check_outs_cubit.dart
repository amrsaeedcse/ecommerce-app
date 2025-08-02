import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'get_check_outs_state.dart';

class GetCheckOutsCubit extends Cubit<GetCheckOutsState> {
  GetCheckOutsCubit() : super(GetCheckOutsLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future<void> getCheckOuts() async {
    try {
      emit(GetCheckOutsLoading());
      List<CheckOutModel> checkOutModels = await fireBaseFireStore.getOrders();
      emit(GetCheckOutsSuccess(checkOutModels));
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("empty")) {
        emit(GetCheckOutsEmpty());
      } else {
        emit(GetCheckOutsFailure());
      }
    }
  }
}
