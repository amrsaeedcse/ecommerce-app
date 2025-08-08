part of 'send_support_cubit.dart';

@immutable
sealed class SendSupportState {}

final class SendSupportSuccess extends SendSupportState {}

final class SendSupportFailure extends SendSupportState {}

final class SendSupportLoading extends SendSupportState {}
