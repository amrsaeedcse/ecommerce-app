import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'add_profile_image_state.dart';

class AddProfileImageCubit extends Cubit<AddProfileImageState> {
  AddProfileImageCubit() : super(AddProfileImageSuccess());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  Future addImage(String image) async {
    try {
      emit(AddProfileImageLoading());
      await fireBaseFireStore.addProfileImage(image);
      emit(AddProfileImageSuccess());
    } catch (e) {
      emit(AddProfileImageFailure());
    }
  }
}
