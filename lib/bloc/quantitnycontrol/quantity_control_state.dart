part of 'quantity_control_cubit.dart';

@immutable
sealed class QuantityControlState {
  final int counter;
  const QuantityControlState(this.counter);
}

final class QuantityControlInitial extends QuantityControlState {
  QuantityControlInitial() : super(1);
}

final class QuantityControlValue extends QuantityControlState {
  QuantityControlValue(super.counter);
}
