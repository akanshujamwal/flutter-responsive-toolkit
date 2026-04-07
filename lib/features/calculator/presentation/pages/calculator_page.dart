import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_size_calculator/features/calculator/presentation/pages/widgets/calc_card.dart';
import '../cubit/calculator_cubit.dart';
import '../cubit/calculator_state.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _dwCtrl = TextEditingController(text: '390');
  final _dhCtrl = TextEditingController(text: '844');
  final _valCtrl = TextEditingController();
  String _type = 'width';

  static const _types = [
    ('width', Icons.width_normal_rounded, 'Width'),
    ('height', Icons.height_rounded, 'Height'),
    ('font', Icons.text_fields_rounded, 'Font'),
    ('radius', Icons.rounded_corner_rounded, 'Radius'),
    ('padding', Icons.padding_rounded, 'Padding'),
    ('icon', Icons.image_rounded, 'Icon'),
  ];

  @override
  void dispose() {
    _dwCtrl.dispose();
    _dhCtrl.dispose();
    _valCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final dw = double.tryParse(_dwCtrl.text) ?? 390;
    final dh = double.tryParse(_dhCtrl.text) ?? 844;
    final val = double.tryParse(_valCtrl.text) ?? 0;
    context.read<CalculatorCubit>().update(
          designWidth: dw,
          designHeight: dh,
          value: val,
          type: _type,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calculate_rounded,
                    color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Value Calculator',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    Text(AppStrings.calcDesc,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Design dimensions ────────────────────────────
          const _Label('Designer Screen'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _dwCtrl,
                  label: 'Design Width',
                  hint: '390',
                  icon: Icons.width_normal_rounded,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextField(
                  controller: _dhCtrl,
                  label: 'Design Height',
                  hint: '844',
                  icon: Icons.height_rounded,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Value type ───────────────────────────────────
          const _Label('Value Type'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _types.map((t) {
              final isSelected = t.$1 == _type;
              return ChoiceChip(
                avatar: Icon(t.$2,
                    size: 14,
                    color: isSelected ? AppColors.accent : Colors.grey),
                label: Text(t.$3),
                selected: isSelected,
                onSelected: (_) {
                  setState(() => _type = t.$1);
                  _calculate();
                },
                selectedColor: AppColors.accent.withOpacity(0.12),
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.accent : null,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                side: BorderSide(
                  color: isSelected ? AppColors.accent : Colors.grey.shade300,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // ── Original value ───────────────────────────────
          const _Label('Original Value (px)'),
          const SizedBox(height: 8),
          AppTextField(
            controller: _valCtrl,
            label: 'Value',
            hint: 'e.g.  100',
            icon: Icons.straighten_rounded,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 28),

          // ── Results ──────────────────────────────────────
          BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              if (state is! CalculatorReady) return const _EmptyHint();
              return _ResultsGrid(state: state);
            },
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
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      );
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Icon(Icons.calculate_outlined,
                size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'Enter a value above and tap Calculate\nto see results across all screen sizes',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsGrid extends StatelessWidget {
  final CalculatorReady state;
  const _ResultsGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    final cols = MediaQuery.of(context).size.width >= 700 ? 5 : 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${state.originalValue.toInt()} px  →  results on ${state.results.length} screens',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: 1.35,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: state.results.length,
          itemBuilder: (_, i) =>
              CalcCard(result: state.results[i], valueType: state.valueType),
        ),
      ],
    );
  }
}
