part of 'get_notifications_cubit.dart';

@immutable
sealed class GetNotificationsState {}

final class GetNotificationsLoading extends GetNotificationsState {}

final class GetNotificationsSuccess extends GetNotificationsState {
  List<NotificationsModel> data;
  GetNotificationsSuccess(this.data);
}

final class GetNotificationsFailure extends GetNotificationsState {}

final class GetNotificationsEmpty extends GetNotificationsState {}
