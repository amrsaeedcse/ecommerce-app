part of 'add_profile_image_cubit.dart';

@immutable
sealed class AddProfileImageState {}

final class AddProfileImageSuccess extends AddProfileImageState {}

final class AddProfileImageLoading extends AddProfileImageState {}

final class AddProfileImageFailure extends AddProfileImageState {}
