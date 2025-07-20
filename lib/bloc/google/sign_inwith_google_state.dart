part of 'sign_inwith_google_cubit.dart';

@immutable
sealed class SignInwithGoogleState {}

final class SignInwithGoogleInitial extends SignInwithGoogleState {}

final class SignInwithGoogleFailure extends SignInwithGoogleState {
  final String message;
  SignInwithGoogleFailure(this.message);
}

final class SignInwithGoogleCancel extends SignInwithGoogleState {}

final class SignInwithGoogleSuccess extends SignInwithGoogleState {}

final class SignInwithGoogleLoading extends SignInwithGoogleState {}

final class SignInwithGoogleNew extends SignInwithGoogleState {}
