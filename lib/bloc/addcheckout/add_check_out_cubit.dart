import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'add_check_out_state.dart';

class AddCheckOutCubit extends Cubit<AddCheckOutState> {
  AddCheckOutCubit() : super(AddCheckOutSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  Future addCheckOut(CheckOutModel checkOutModel) async {
    try {
      emit(AddCheckOutLoading());
      await fireBaseFireStore.addCheckOutWithProducts(checkOutModel);
      emit(AddCheckOutSuccess());
    } catch (e) {
      print("eroro");
      emit(AddCheckOutFailure());
    }
  }
}
