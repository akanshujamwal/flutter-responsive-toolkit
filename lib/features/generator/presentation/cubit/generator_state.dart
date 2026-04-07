import 'package:equatable/equatable.dart';
import '../../domain/entities/screen_config.dart';

abstract class GeneratorState extends Equatable {
  const GeneratorState();

  @override
  List<Object?> get props => [];
}

class GeneratorInitial extends GeneratorState {
  const GeneratorInitial();
}

class GeneratorLoading extends GeneratorState {
  const GeneratorLoading();
}

class GeneratorSuccess extends GeneratorState {
  final String generatedCode;
  final ScreenConfig config;

  const GeneratorSuccess({required this.generatedCode, required this.config});

  @override
  List<Object?> get props => [generatedCode, config];
}

// Sub-states extend GeneratorSuccess so the UI keeps the code visible
class GeneratorCopied extends GeneratorSuccess {
  const GeneratorCopied({required super.generatedCode, required super.config});
}

class GeneratorDownloading extends GeneratorSuccess {
  const GeneratorDownloading(
      {required super.generatedCode, required super.config});
}

class GeneratorError extends GeneratorState {
  final String message;
  const GeneratorError(this.message);

  @override
  List<Object?> get props => [message];
}
