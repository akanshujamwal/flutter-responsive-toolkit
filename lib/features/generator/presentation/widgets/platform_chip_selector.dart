import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class PlatformChipSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PlatformChipSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _icons = {
    'Mobile': Icons.smartphone_rounded,
    'Tablet': Icons.tablet_rounded,
    'Web': Icons.web_rounded,
    'All': Icons.devices_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: AppStrings.platforms.map((p) {
        final isSelected = p == selected;
        return ChoiceChip(
          avatar: Icon(_icons[p],
              size: 14, color: isSelected ? AppColors.primary : Colors.grey),
          label: Text(p),
          selected: isSelected,
          onSelected: (_) => onChanged(p),
          selectedColor: AppColors.primary.withOpacity(0.12),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : null,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        );
      }).toList(),
    );
  }
}
