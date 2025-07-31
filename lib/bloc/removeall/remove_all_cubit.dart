import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'remove_all_state.dart';

class RemoveAllCubit extends Cubit<RemoveAllState> {
  RemoveAllCubit() : super(RemoveAllSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future deleteAll() async {
    try {
      emit(RemoveAllLoading());
      await fireBaseFireStore.removeAll();
      emit(RemoveAllSuccess());
    } catch (e) {
      emit(RemoveAllFailure());
    }
  }
}
