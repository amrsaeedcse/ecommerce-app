part of 'add_cart_control_cubit.dart';

@immutable
sealed class AddCartControlState {}

final class AddCartControlLoading extends AddCartControlState {}

final class AddCartControlFailure extends AddCartControlState {}

final class AddCartControlSuccess extends AddCartControlState {}
