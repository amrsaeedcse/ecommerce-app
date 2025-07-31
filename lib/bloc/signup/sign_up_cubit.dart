import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/fireauth/firebaseauth.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final FireBaseAuth firebaseAuth = getIt<FireBaseAuth>();

  Future signUp({
    required String email,
    required String pass,
    required String name,
    required String age,
    required String sex,
  }) async {
    emit(SignUpLoading());
    final user = await firebaseAuth.signUp(
      email: email,
      pass: pass,
      name: name,
      age: age,
      sex: sex,
    );
    if (user == AuthFailure.unknown || user == AuthFailure.fireStoreError) {
      emit(SignUpFailure());
    } else if (user == AuthFailure.emailAlreadyInUse) {
      emit(SignUpEmailError());
    } else {
      emit(SignUpSuccess());
    }
  }
}
