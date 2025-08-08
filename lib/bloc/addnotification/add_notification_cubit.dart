import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/data/notifications/notificationsmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:meta/meta.dart';

import '../../getit/service_locator.dart';

part 'add_notification_state.dart';

class AddNotificationCubit extends Cubit<AddNotificationState> {
  AddNotificationCubit() : super(AddNotificationSuccess());

  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future addNotification(NotificationsModel notificationsModel) async {
    try {
      emit(AddNotificationLoading());
      await fireBaseFireStore.addNotifications(notificationsModel);
      emit(AddNotificationSuccess());
    } catch (e) {
      emit(AddNotificationFailure());
    }
  }
}
