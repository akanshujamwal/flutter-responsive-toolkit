import 'package:flutter/material.dart';
import '../widgets/config_form.dart';
import '../widgets/code_preview_widget.dart';
import '../../../../core/constants/app_colors.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    return isWide ? const _WideLayout() : const _NarrowLayout();
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 380,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _PageHeader(),
                SizedBox(height: 20),
                ConfigForm()
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        const Expanded(child: CodePreviewWidget()),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          _PageHeader(),
          SizedBox(height: 16),
          ConfigForm(),
          SizedBox(height: 16),
          SizedBox(height: 500, child: CodePreviewWidget()),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text('Extension Generator',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your designer's screen dimensions to generate\na complete responsive extension for your project.",
          style:
              TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
        ),
      ],
    );
  }
}
