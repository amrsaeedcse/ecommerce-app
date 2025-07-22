import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'store_google_state.dart';

class StoreGoogleCubit extends Cubit<StoreGoogleState> {
  StoreGoogleCubit() : super(StoreGoogleInitial());
  FireBaseFireStore db = getIt<FireBaseFireStore>();
  Future store({
    required String email,
    required String name,
    required String age,
    required String sex,
    required String userId,
  }) async {
    try {
      emit(StoreGoogleLoading());
      await db.addUserWithGoogle(
        email: email,
        name: name,
        age: age,
        sex: sex,
        userId: userId,
      );
      emit(StoreGoogleSuccess());
    } catch (e) {
      emit(StoreGoogleFailure());
    }
  }
}
