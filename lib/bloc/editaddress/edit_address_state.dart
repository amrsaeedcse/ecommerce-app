part of 'edit_address_cubit.dart';

@immutable
sealed class EditAddressState {}

final class EditAddressSuccess extends EditAddressState {}

final class EditAddressFailure extends EditAddressState {}

final class EditAddressLoading extends EditAddressState {}
