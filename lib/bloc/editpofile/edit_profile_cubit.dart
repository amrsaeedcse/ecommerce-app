import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';
import '../../widgets/user.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future editProfile(UserModel userModel) async {
    try {
      emit(EditProfileLoading());
      await fireBaseFireStore.editProfile(userModel);
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileFailure());
    }
  }
}
