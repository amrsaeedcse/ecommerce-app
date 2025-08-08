part of 'get_profile_cubit.dart';

@immutable
sealed class GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileFailure extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final UserModel userModel;
  GetProfileSuccess(this.userModel);
}
