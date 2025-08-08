part of 'get_wish_list_cubit.dart';

@immutable
sealed class GetWishListState {}

final class GetWishListSuccess extends GetWishListState {
  final List<ProductModel> productModels;
  GetWishListSuccess(this.productModels);
}

final class GetWishListLoading extends GetWishListState {}

final class GetWishListFailure extends GetWishListState {}

final class GetWishListEmpty extends GetWishListState {}
