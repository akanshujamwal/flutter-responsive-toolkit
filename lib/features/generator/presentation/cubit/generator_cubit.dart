import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/screen_config.dart';
import '../../../../core/utils/extension_generator.dart';
import '../../../../core/utils/file_downloader.dart';
import 'generator_state.dart';

class GeneratorCubit extends Cubit<GeneratorState> {
  GeneratorCubit() : super(const GeneratorInitial());

  Future<void> generate(ScreenConfig config) async {
    emit(const GeneratorLoading());
    await Future.delayed(const Duration(milliseconds: 700)); // shimmer UX

    try {
      final code = ExtensionGenerator.generate(
        designWidth: config.width,
        designHeight: config.height,
        platform: config.platform,
        extensionName: config.extensionName,
      );
      emit(GeneratorSuccess(generatedCode: code, config: config));
    } catch (e) {
      emit(GeneratorError(e.toString()));
    }
  }

  Future<void> copyToClipboard(String code, ScreenConfig config) async {
    await Clipboard.setData(ClipboardData(text: code));
    emit(GeneratorCopied(generatedCode: code, config: config));
    await Future.delayed(const Duration(seconds: 2));
    emit(GeneratorSuccess(generatedCode: code, config: config));
  }

  Future<void> downloadFile(String code, ScreenConfig config) async {
    emit(GeneratorDownloading(generatedCode: code, config: config));
    try {
      final fileName =
          '${_toSnake(config.extensionName.isEmpty ? "app_responsive" : config.extensionName)}.dart';
      await downloadDartFile(content: code, fileName: fileName);
      emit(GeneratorSuccess(generatedCode: code, config: config));
    } catch (e) {
      emit(GeneratorError(e.toString()));
    }
  }

  String _toSnake(String s) => s
      .replaceAllMapped(
          RegExp(r'[A-Z]'), (m) => '_${m.group(0)!.toLowerCase()}')
      .replaceAll(RegExp(r'^_'), '');
}
