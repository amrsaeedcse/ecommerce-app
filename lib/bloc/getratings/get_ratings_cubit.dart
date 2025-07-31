import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'get_ratings_state.dart';

class GetRatingsCubit extends Cubit<GetRatingsState> {
  GetRatingsCubit() : super(GetRatingsLoading());
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  List<RatingModel> ratings = [];
  Future getRating(String pId) async {
    try {
      emit(GetRatingsLoading());
      ratings = await fireBaseFireStore.getRating(pId);
      emit(GetRatingsSuccess(ratings));
    } catch (e) {
      if (e.toString().contains("no ratings")) {
        emit(GetRatingsEmpty());
      } else {
        emit(GetRatingsFailure());
      }
    }
  }
}
