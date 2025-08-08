part of 'sign_out_cubit.dart';

@immutable
sealed class SignOutState {}

final class SignOutFailure extends SignOutState {}

final class SignOutLoading extends SignOutState {}

final class SignOutSuccess extends SignOutState {}
