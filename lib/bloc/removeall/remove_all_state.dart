part of 'remove_all_cubit.dart';

@immutable
sealed class RemoveAllState {}

final class RemoveAllSuccess extends RemoveAllState {}

final class RemoveAllLoading extends RemoveAllState {}

final class RemoveAllFailure extends RemoveAllState {}
