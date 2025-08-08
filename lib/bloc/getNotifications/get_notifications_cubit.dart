import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/notifications/notificationsmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit() : super(GetNotificationsLoading());

  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future getNotifications() async {
    try {
      emit(GetNotificationsLoading());
      List<NotificationsModel> data = await fireBaseFireStore
          .getNotifications();
      emit(GetNotificationsSuccess(data));
    } catch (e) {
      if (e.toString().contains("empty")) {
        emit(GetNotificationsEmpty());
      } else {
        emit(GetNotificationsFailure());
      }
    }
  }
}
