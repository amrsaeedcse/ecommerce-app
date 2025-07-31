import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../firebase/firestore/FireBaseFireStore.dart';
import '../../getit/service_locator.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  Future addAddress(AddressModel addressModel) async {
    try {
      emit(AddAddressLoading());
      await fireBaseFireStore.addAddress(addressModel);
      emit(AddAddressSuccess());
    } catch (e) {
      emit(AddAddressFailure());
    }
  }
}
