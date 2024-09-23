import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:repositories/repositories.dart';

class HiveTile extends StatelessWidget {
  final Hive hive;
  final Color color;
  final Queen? queen;
  final void Function(Hive hive) onPressed;
  final void Function(Hive hive) onDismissed;
  final Future<bool?> Function(Hive hive) confirmDismiss;

  const HiveTile({
    super.key,
    required this.hive,
    required this.queen,
    required this.color,
    required this.onPressed,
    required this.onDismissed,
    required this.confirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => confirmDismiss(hive),
      onDismissed: (_) => onDismissed(hive),
      background: Container(color: AppColors.failure),
      key: ValueKey(hive),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => onPressed(hive),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: AppColors.white,
            elevation: 3,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHiveLabel(context),
                  _buildQueenLabel(context),
                ],
              ),
              const Icon(Icons.drag_indicator)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHiveLabel(BuildContext context) {
    return Row(
      children: [
        Text(
          hive.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const SizedBox(width: 10),
        Text(
          hive.type,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.text.withAlpha(60),
              ),
        )
      ],
    );
  }

  Widget _buildQueenLabel(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppVectors.bee,
          width: 24,
          height: 24,
          colorFilter: queen == null
              ? const ColorFilter.mode(
                  Color.fromARGB(60, 0, 0, 0), BlendMode.srcIn)
              : null,
        ),
        const SizedBox(width: 5),
        Text(
          queen?.breed ?? 'no_queen'.tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: queen == null
                    ? AppColors.text.withAlpha(60)
                    : AppColors.text,
              ),
        )
      ],
    );
  }
}