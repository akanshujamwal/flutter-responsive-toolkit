import 'package:equatable/equatable.dart';

class ScreenConfig extends Equatable {
  final double width;
  final double height;
  final String platform;
  final String extensionName;

  const ScreenConfig({
    required this.width,
    required this.height,
    required this.platform,
    required this.extensionName,
  });

  @override
  List<Object?> get props => [width, height, platform, extensionName];
}
