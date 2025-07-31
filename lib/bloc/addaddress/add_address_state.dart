part of 'add_address_cubit.dart';

@immutable
sealed class AddAddressState {}

final class AddAddressLoading extends AddAddressState {}

final class AddAddressFailure extends AddAddressState {}

final class AddAddressSuccess extends AddAddressState {}
