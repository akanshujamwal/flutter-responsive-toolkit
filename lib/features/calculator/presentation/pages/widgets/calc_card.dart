import 'package:flutter/material.dart';
import 'package:widget_size_calculator/core/constants/app_colors.dart';
import 'package:widget_size_calculator/features/calculator/domain/entities/calc_result.dart';


class CalcCard extends StatelessWidget {
  final CalcResult result;
  final String valueType;

  const CalcCard({super.key, required this.result, required this.valueType});

  double get _resultValue {
    switch (valueType) {
      case 'height':
        return result.resultHeight;
      case 'font':
      case 'radius':
      case 'padding':
      case 'icon':
        return result.resultAvg;
      default:
        return result.resultWidth; // 'width'
    }
  }

  String get _methodLabel {
    switch (valueType) {
      case 'width':
        return '.w()';
      case 'height':
        return '.h()';
      case 'font':
        return '.sp()';
      case 'radius':
        return '.r()';
      case 'padding':
        return 'pAll()';
      case 'icon':
        return 'icon()';
      default:
        return '→';
    }
  }

  Color get _color {
    switch (valueType) {
      case 'height':
        return AppColors.accent;
      case 'font':
        return const Color(0xFFFFB347);
      case 'radius':
        return const Color(0xFFFF6B6B);
      case 'padding':
        return const Color(0xFF89B4FA);
      case 'icon':
        return const Color(0xFFCBA6F7);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _color.withOpacity(0.25)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_color.withOpacity(0.07), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Screen name + method badge
          Row(
            children: [
              Expanded(
                child: Text(
                  result.screenName,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _methodLabel,
                  style: TextStyle(
                      fontSize: 9,
                      color: _color,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          // Result value + dimensions
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _resultValue.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w800, color: _color),
              ),
              Text(
                '${result.screenWidth.toInt()} × ${result.screenHeight.toInt()} px',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
