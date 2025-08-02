part of 'add_check_out_cubit.dart';

@immutable
sealed class AddCheckOutState {}

final class AddCheckOutSuccess extends AddCheckOutState {}

final class AddCheckOutFailure extends AddCheckOutState {}

final class AddCheckOutLoading extends AddCheckOutState {}
