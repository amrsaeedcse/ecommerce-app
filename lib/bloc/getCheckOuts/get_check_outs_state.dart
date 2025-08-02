part of 'get_check_outs_cubit.dart';

@immutable
sealed class GetCheckOutsState {}

final class GetCheckOutsFailure extends GetCheckOutsState {}

final class GetCheckOutsLoading extends GetCheckOutsState {}

final class GetCheckOutsEmpty extends GetCheckOutsState {}

final class GetCheckOutsSuccess extends GetCheckOutsState {
  List<CheckOutModel> checkOutModels;
  GetCheckOutsSuccess(this.checkOutModels);
}
