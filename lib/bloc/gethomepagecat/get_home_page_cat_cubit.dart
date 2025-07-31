import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_home_page_cat_state.dart';

class GetHomePageCatCubit extends Cubit<GetHomePageCatState> {
  GetHomePageCatCubit() : super(GetHomePageCatLoading());

  final FireBaseFireStore db = getIt<FireBaseFireStore>();

  Future getHomePageCat(BuildContext c) async {
    try {
      await db.getHomePageCat();
      emit(GetHomePageCatSuccess());
      print(state);
    } catch (e) {
      print(e);
      if (e.toString().contains("no Products")) {
        emit(GetHomePageCatEmpty());
      } else {
        emit(GetHomePageCatFailure());
      }
    }
  }
}
