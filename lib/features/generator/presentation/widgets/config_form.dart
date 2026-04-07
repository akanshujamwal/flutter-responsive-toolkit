import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/generator_cubit.dart';
import '../../domain/entities/screen_config.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'platform_chip_selector.dart';

class ConfigForm extends StatefulWidget {
  const ConfigForm({super.key});

  @override
  State<ConfigForm> createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm> {
  final _formKey = GlobalKey<FormState>();
  final _widthCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _nameCtrl = TextEditingController(text: 'AppResponsive');
  String _platform = 'Mobile';

  @override
  void dispose() {
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _applyPreset(List<double> dims) => setState(() {
        _widthCtrl.text = dims[0].toInt().toString();
        _heightCtrl.text = dims[1].toInt().toString();
      });

  void _generate() {
    if (!_formKey.currentState!.validate()) return;
    context.read<GeneratorCubit>().generate(
          ScreenConfig(
            width: double.parse(_widthCtrl.text),
            height: double.parse(_heightCtrl.text),
            platform: _platform,
            extensionName: _nameCtrl.text.trim(),
          ),
        );
  }

  String? _numValidator(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    final n = double.tryParse(v);
    if (n == null) return 'Invalid number';
    if (n <= 0) return 'Must be greater than 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Presets ────────────────────────────────────────
          _Label('Quick Presets'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppStrings.presetScreens.entries.map((e) {
              return _PresetChip(
                name: e.key,
                dims: e.value,
                onTap: () => _applyPreset(e.value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // ── Dimensions ─────────────────────────────────────
          _Label('Designer Screen Dimensions'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _widthCtrl,
                  label: 'Width (px)',
                  hint: '390',
                  icon: Icons.width_normal_rounded,
                  keyboardType: TextInputType.number,
                  validator: _numValidator,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextField(
                  controller: _heightCtrl,
                  label: 'Height (px)',
                  hint: '844',
                  icon: Icons.height_rounded,
                  keyboardType: TextInputType.number,
                  validator: _numValidator,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Extension Name ──────────────────────────────────
          _Label('Extension Name'),
          const SizedBox(height: 8),
          AppTextField(
            controller: _nameCtrl,
            label: 'Class / Extension Name',
            hint: 'AppResponsive',
            icon: Icons.drive_file_rename_outline_rounded,
            validator: (_) => null,
          ),
          const SizedBox(height: 16),

          // ── Platform ────────────────────────────────────────
          _Label('Target Platform'),
          const SizedBox(height: 8),
          PlatformChipSelector(
            selected: _platform,
            onChanged: (p) => setState(() => _platform = p),
          ),
          const SizedBox(height: 24),

          // ── Generate Button ─────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _generate,
              icon: const Icon(Icons.auto_awesome_rounded, size: 18),
              label: const Text(
                AppStrings.generate,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.2),
      );
}

class _PresetChip extends StatelessWidget {
  final String name;
  final List<double> dims;
  final VoidCallback onTap;

  const _PresetChip(
      {required this.name, required this.dims, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary.withOpacity(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            Text(
              '${dims[0].toInt()} × ${dims[1].toInt()}',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
