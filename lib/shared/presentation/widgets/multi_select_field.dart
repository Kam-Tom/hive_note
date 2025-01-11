import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class MultiSelectField<T> extends StatelessWidget {
  final List<T> initialValue;
  final List<MultiSelectItem<T>> items;
  final String title;
  final String buttonText;
  final Function(List<T>) onConfirm;

  const MultiSelectField({
    super.key,
    required this.initialValue,
    required this.items,
    required this.title,
    required this.buttonText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = initialValue.isNotEmpty;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
        gradient: isSelected ? LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.secondary.withOpacity(0.1),
          ],
        ) : null,
      ),
      child: MultiSelectDialogField<T>(
        checkColor: AppColors.white,
        selectedColor: AppColors.secondary,
        initialValue: initialValue,
        items: items,
        title: Text(title),
        buttonText: Text(
          buttonText,
          overflow: TextOverflow.ellipsis,
        ),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        selectedItemsTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        onConfirm: onConfirm,
        chipDisplay: MultiSelectChipDisplay.none(),
        dialogHeight: 200,
        dialogWidth: 200,
        searchable: false,
      ),
    );
  }
}
