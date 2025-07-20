part of 'store_google_cubit.dart';

@immutable
sealed class StoreGoogleState {}

final class StoreGoogleInitial extends StoreGoogleState {}

final class StoreGoogleLoading extends StoreGoogleState {}

final class StoreGoogleFailure extends StoreGoogleState {}

final class StoreGoogleSuccess extends StoreGoogleState {}
