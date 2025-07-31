part of 'get_cart_control_cubit.dart';

@immutable
sealed class GetCartControlState {}

final class GetCartControlLoading extends GetCartControlState {}

final class GetCartControlSuccess extends GetCartControlState {
  final List<CartModel> cartModels;
  GetCartControlSuccess(this.cartModels);
}

final class GetCartControlFailure extends GetCartControlState {}

final class GetCartControlEmpty extends GetCartControlState {}
