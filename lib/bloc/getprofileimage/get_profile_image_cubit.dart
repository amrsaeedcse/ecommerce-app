import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'get_profile_image_state.dart';

class GetProfileImageCubit extends Cubit<GetProfileImageState> {
  GetProfileImageCubit() : super(GetProfileImageLoading());

  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future getImage() async {
    try {
      emit(GetProfileImageLoading());
      String image = await fireBaseFireStore.getProfileImage();
      emit(GetProfileImageSuccess(image));
    } catch (e) {
      if (e.toString().contains("noImage")) {
        emit(GetProfileImageNoImage());
      } else {
        emit(GetProfileImageFailure());
      }
    }
  }
}
