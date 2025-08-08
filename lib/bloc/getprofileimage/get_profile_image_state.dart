part of 'get_profile_image_cubit.dart';

@immutable
sealed class GetProfileImageState {}

final class GetProfileImageLoading extends GetProfileImageState {}

final class GetProfileImageSuccess extends GetProfileImageState {
  String image;
  GetProfileImageSuccess(this.image);
}

final class GetProfileImageNoImage extends GetProfileImageState {}

final class GetProfileImageFailure extends GetProfileImageState {}
