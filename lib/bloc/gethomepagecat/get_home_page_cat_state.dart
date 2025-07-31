part of 'get_home_page_cat_cubit.dart';

@immutable
sealed class GetHomePageCatState {}

final class GetHomePageCatFailure extends GetHomePageCatState {}

final class GetHomePageCatLoading extends GetHomePageCatState {}

final class GetHomePageCatSuccess extends GetHomePageCatState {}

final class GetHomePageCatEmpty extends GetHomePageCatState {}
