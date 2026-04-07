import 'package:equatable/equatable.dart';

class CalcResult extends Equatable {
  final String screenName;
  final double screenWidth;
  final double screenHeight;
  final double resultWidth;
  final double resultHeight;
  final double resultAvg; // for font/radius/padding/icon

  const CalcResult({
    required this.screenName,
    required this.screenWidth,
    required this.screenHeight,
    required this.resultWidth,
    required this.resultHeight,
    required this.resultAvg,
  });

  @override
  List<Object?> get props => [screenName, screenWidth, screenHeight];
}
