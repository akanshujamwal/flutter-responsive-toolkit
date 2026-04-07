import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_state.dart';
import '../../domain/entities/calc_result.dart';
import '../../../../core/constants/app_strings.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorInitial());

  double _dW = 390, _dH = 844, _value = 0;
  String _type = 'width';

  void update({
    double? designWidth,
    double? designHeight,
    double? value,
    String? type,
  }) {
    if (designWidth != null) _dW = designWidth;
    if (designHeight != null) _dH = designHeight;
    if (value != null) _value = value;
    if (type != null) _type = type;
    _calculate();
  }

  void _calculate() {
    if (_value <= 0) return;

    final results = AppStrings.presetScreens.entries.map((e) {
      final sw = e.value[0], sh = e.value[1];
      final wScale = sw / _dW;
      final hScale = sh / _dH;
      final avg = (wScale + hScale) / 2;
      return CalcResult(
        screenName: e.key,
        screenWidth: sw,
        screenHeight: sh,
        resultWidth: _value * wScale,
        resultHeight: _value * hScale,
        resultAvg: _value * avg,
      );
    }).toList();

    emit(CalculatorReady(
      designWidth: _dW,
      designHeight: _dH,
      originalValue: _value,
      valueType: _type,
      results: results,
    ));
  }
}
