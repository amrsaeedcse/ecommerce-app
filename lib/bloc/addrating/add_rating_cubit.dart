import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'add_rating_state.dart';

class AddRatingCubit extends Cubit<AddRatingState> {
  AddRatingCubit() : super(AddRatingInitial());

  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future addRating(RatingModel ratingModel, String pId) async {
    try {
      emit(AddRatingLoading());
      await fireBaseFireStore.addRating(ratingModel, pId);
      emit(AddRatingSuccess());
    } catch (e) {
      emit(AddRatingFailure());
    }
  }
}
