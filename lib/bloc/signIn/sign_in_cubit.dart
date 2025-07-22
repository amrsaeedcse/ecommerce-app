import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../firebase/firebaseauth.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final FireBaseAuth firebaseAuth = getIt<FireBaseAuth>();
  Future<void> login(String email, String password) async {
    emit(SignInLoading());

    try {
      await firebaseAuth.signIn(email: email, pass: password);
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      String msg = _mapErrorToMessage(e.code);
      emit(SignInFailure(msg));
    } catch (e) {
      emit(SignInFailure("error"));
    }
  }

  String _mapErrorToMessage(String code) {
    switch (code) {
      case 'invalid_email':
        return 'Wrong email';
      case 'user_disabled':
        return 'تم تعطيل المستخدم';
      case 'user_not_found':
        return 'المستخدم غير موجود';
      case 'wrong_password':
        return 'كلمة السر غير صحيحة';
      case 'unknown_error':
      default:
        return 'Error';
    }
  }
}
