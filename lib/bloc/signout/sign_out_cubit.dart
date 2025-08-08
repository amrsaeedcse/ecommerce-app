import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/fireauth/firebaseauth.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutSuccess());

  final FireBaseAuth fireBaseAuth = getIt<FireBaseAuth>();
  Future signOut() async {
    try {
      emit(SignOutLoading());
      await fireBaseAuth.signOut();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure());
    }
  }
}
