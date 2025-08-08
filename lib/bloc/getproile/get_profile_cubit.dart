import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';
import '../../widgets/user.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  Future getProfile() async {
    try {
      emit(GetProfileLoading());
      UserModel userModel = await fireBaseFireStore.getProfile();
      emit(GetProfileSuccess(userModel));
    } catch (e) {
      emit(GetProfileFailure());
    }
  }
}
