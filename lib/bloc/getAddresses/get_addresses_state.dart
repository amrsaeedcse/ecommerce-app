part of 'get_addresses_cubit.dart';

@immutable
sealed class GetAddressesState {}

final class GetAddressesLoading extends GetAddressesState {}

final class GetAddressesFailure extends GetAddressesState {}

final class GetAddressesSuccess extends GetAddressesState {
  final List<AddressModel> addressModels;
  GetAddressesSuccess(this.addressModels);
}

final class GetAddressesEmpty extends GetAddressesState {}
