part of 'age_control_cubit.dart';

@immutable
sealed class AgeControlState {
  final String? ageSelected;

  const AgeControlState(this.ageSelected);
}

final class AgeControlInitial extends AgeControlState {
  const AgeControlInitial() : super(null);
}

final class AgeControlValue extends AgeControlState {
  const AgeControlValue(String age) : super(age);
}
