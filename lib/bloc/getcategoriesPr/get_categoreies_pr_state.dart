part of 'get_categoreies_pr_cubit.dart';

@immutable
sealed class GetCategoreiesPrState {}

final class GetCategoreiesPrInitial extends GetCategoreiesPrState {}

final class GetCategoreiesPrLaoding extends GetCategoreiesPrState {}

final class GetCategoreiesPrSuccess extends GetCategoreiesPrState {}

final class GetCategoreiesPrFailure extends GetCategoreiesPrState {}

final class GetCategoreiesPrEmpty extends GetCategoreiesPrState {}
