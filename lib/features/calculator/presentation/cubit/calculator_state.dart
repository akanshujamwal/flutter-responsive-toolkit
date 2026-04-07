import 'package:equatable/equatable.dart';
import '../../domain/entities/calc_result.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState {
  const CalculatorInitial();
}

class CalculatorReady extends CalculatorState {
  final double designWidth;
  final double designHeight;
  final double originalValue;
  final String valueType;
  final List<CalcResult> results;

  const CalculatorReady({
    required this.designWidth,
    required this.designHeight,
    required this.originalValue,
    required this.valueType,
    required this.results,
  });

  @override
  List<Object?> get props =>
      [designWidth, designHeight, originalValue, valueType];
}
