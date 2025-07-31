import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/firebase/fireauth/firebaseauth.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_inwith_google_state.dart';

class SignInwithGoogleCubit extends Cubit<SignInwithGoogleState> {
  final FireBaseAuth fireBaseAuth = getIt<FireBaseAuth>();
  SignInwithGoogleCubit() : super(SignInwithGoogleInitial());

  Future signInWithGoogle() async {
    try {
      emit(SignInwithGoogleLoading());
      await fireBaseAuth.signInWithGoogle();
      emit(SignInwithGoogleSuccess());
    } catch (e) {
      //just to confirm
      final message = e.toString();
      if (message.contains("get-out")) {
        emit(SignInwithGoogleFailure("user cancelled"));
      } else if (message.contains("isnt-here")) {
        emit(SignInwithGoogleNew());
      } else {
        emit(SignInwithGoogleFailure("error"));
      }
    }
    print(state);
  }
}
