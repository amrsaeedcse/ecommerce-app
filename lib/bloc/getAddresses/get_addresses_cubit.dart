import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/bloc/getratings/get_ratings_cubit.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'get_addresses_state.dart';

class GetAddressesCubit extends Cubit<GetAddressesState> {
  GetAddressesCubit() : super(GetAddressesLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future getAddresses() async {
    try {
      emit(GetAddressesLoading());
      List<AddressModel> addressModels = await fireBaseFireStore.getAddresses();
      print("hello");
      emit(GetAddressesSuccess(addressModels));
    } catch (e) {
      if (e.toString().contains('no Address')) {
        emit(GetAddressesEmpty());
      } else {
        emit(GetAddressesFailure());
      }
    }
  }

  void ref() {
    emit(GetAddressesSuccess((state as GetAddressesSuccess).addressModels));
  }
}
