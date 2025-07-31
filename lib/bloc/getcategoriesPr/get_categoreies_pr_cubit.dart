import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:meta/meta.dart';

part 'get_categoreies_pr_state.dart';

class GetCategoreiesPrCubit extends Cubit<GetCategoreiesPrState> {
  GetCategoreiesPrCubit() : super(GetCategoreiesPrLaoding());
  FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future getCategoriesPr(String category) async {
    try {
      emit(GetCategoreiesPrLaoding());
      await fireBaseFireStore.getCategoryProducts(category);
      emit(GetCategoreiesPrSuccess());
    } catch (e) {
      if (e.toString().contains("no Products")) {
        emit(GetCategoreiesPrEmpty());
      } else {
        emit(GetCategoreiesPrFailure());
      }
    }
  }
}
