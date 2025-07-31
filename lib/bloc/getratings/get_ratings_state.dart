part of 'get_ratings_cubit.dart';

@immutable
sealed class GetRatingsState {}

final class GetRatingsLoading extends GetRatingsState {}

final class GetRatingsFailure extends GetRatingsState {}

final class GetRatingsEmpty extends GetRatingsState {}

final class GetRatingsSuccess extends GetRatingsState {
  final List<RatingModel> ratings;
  GetRatingsSuccess(this.ratings);
}
