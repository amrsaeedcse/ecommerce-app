import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit() : super(ForgetPassInitial());

  Future sendPassReset(String email) async {
    try {
      emit(ForgetPassLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgetPassSuccess());
    } catch (e) {
      emit(ForgetPassFailure());
    }
  }
}
