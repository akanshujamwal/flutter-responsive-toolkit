import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import '../cubit/generator_cubit.dart';
import '../cubit/generator_state.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class CodePreviewWidget extends StatelessWidget {
  const CodePreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratorCubit, GeneratorState>(
      builder: (context, state) {
        if (state is GeneratorLoading) return const _ShimmerCode();
        if (state is GeneratorSuccess) return _CodeView(state: state);
        if (state is GeneratorError) return _ErrorView(state.message);
        return const _EmptyState();
      },
    );
  }
}

// ── Empty ──────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.code_rounded, size: 72, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            AppStrings.noPreview,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey.shade500, fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }
}

// ── Error ──────────────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 48, color: AppColors.error),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: AppColors.error)),
        ],
      ),
    );
  }
}

// ── Shimmer ────────────────────────────────────────────────────
class _ShimmerCode extends StatelessWidget {
  const _ShimmerCode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.codeBg,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fake toolbar
          Row(children: [
            _dot(Colors.red),
            const SizedBox(width: 6),
            _dot(Colors.yellow),
            const SizedBox(width: 6),
            _dot(Colors.green),
          ]),
          const SizedBox(height: 20),
          ...List.generate(
              22,
              (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ShimmerLoading(
                      isDark: true,
                      height: 13,
                      width: i % 4 == 0
                          ? double.infinity
                          : (i % 3 == 0 ? 280 : (i % 2 == 0 ? 180 : 240)),
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: c, shape: BoxShape.circle));
}

// ── Code View ──────────────────────────────────────────────────
class _CodeView extends StatelessWidget {
  final GeneratorSuccess state;
  const _CodeView({required this.state});

  String get _fileName {
    final raw = state.config.extensionName.isEmpty
        ? 'app_responsive'
        : state.config.extensionName;
    return '${_snake(raw)}.dart';
  }

  String _snake(String s) => s
      .replaceAllMapped(
          RegExp(r'[A-Z]'), (m) => '_${m.group(0)!.toLowerCase()}')
      .replaceAll(RegExp(r'^_'), '');

  @override
  Widget build(BuildContext context) {
    final isCopied = state is GeneratorCopied;
    final isDownloading = state is GeneratorDownloading;

    return Column(
      children: [
        // ── Toolbar ────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFF161622),
          child: Row(
            children: [
              _Dot(Colors.red),
              const SizedBox(width: 6),
              _Dot(Colors.yellow),
              const SizedBox(width: 6),
              _Dot(Colors.green),
              const SizedBox(width: 14),
              Text(
                _fileName,
                style: const TextStyle(
                  color: Color(0xFF9898B0),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              const Spacer(),
              _ActionBtn(
                icon: isCopied ? Icons.check_rounded : Icons.copy_rounded,
                label: isCopied ? AppStrings.copied : AppStrings.copyCode,
                color: isCopied ? AppColors.success : Colors.white,
                onTap: isCopied
                    ? null
                    : () => context
                        .read<GeneratorCubit>()
                        .copyToClipboard(state.generatedCode, state.config),
              ),
              const SizedBox(width: 6),
              _ActionBtn(
                icon: isDownloading
                    ? Icons.hourglass_top_rounded
                    : Icons.download_rounded,
                label: isDownloading ? 'Saving…' : AppStrings.downloadFile,
                color: Colors.white,
                onTap: isDownloading
                    ? null
                    : () => context
                        .read<GeneratorCubit>()
                        .downloadFile(state.generatedCode, state.config),
              ),
            ],
          ),
        ),

        // ── Code ───────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            child: HighlightView(
              state.generatedCode,
              language: 'dart',
              theme: atomOneDarkTheme,
              padding: const EdgeInsets.all(20),
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.65,
              ),
            ),
          ),
        ),

        // ── Status bar ─────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          color: const Color(0xFF0D0D1A),
          child: Row(
            children: [
              _Stat('Design',
                  '${state.config.width.toInt()} × ${state.config.height.toInt()}'),
              const SizedBox(width: 20),
              _Stat('Platform', state.config.platform),
              const SizedBox(width: 20),
              _Stat('Lines', '${state.generatedCode.split('\n').length}'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot(this.color);

  @override
  Widget build(BuildContext context) => Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionBtn(
      {required this.icon,
      required this.label,
      required this.color,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 13, color: color),
      label: Text(label, style: TextStyle(fontSize: 11, color: color)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.08),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontSize: 11, color: Color(0xFF6C7086)),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9898B0),
                fontWeight: FontWeight.w600),
          ),
        ]),
      );
}
