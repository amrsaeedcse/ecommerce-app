import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(EditAddressSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future edit(AddressModel addressModel, AddressModel newAddressModel) async {
    try {
      emit(EditAddressLoading());
      await fireBaseFireStore.editAddress(addressModel, newAddressModel);
      emit(EditAddressSuccess());
    } catch (e) {
      emit(EditAddressFailure());
    }
  }
}
