import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/shared/extenstions/models/queen_get_color.dart';
import 'package:repositories/repositories.dart';

class QueenTile extends StatelessWidget {
  final Queen queen;
  final Hive? hive;
  final Color color;
  final void Function(Queen queen) onPressed;
  final void Function(Queen queen) onDismissed;
  final Future<bool?> Function(Queen queen) confirmDismiss;

  const QueenTile({
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
      confirmDismiss: (_) => confirmDismiss(queen),
      onDismissed: (_) => onDismissed(queen),
      background: Container(color: AppColors.failure),
      key: ValueKey(queen),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => onPressed(queen),
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
                  _buildQueenLabel(context),
                  _buildHiveLabel(context),
                ],
              ),
              const Icon(Icons.drag_indicator)
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildQueenLabel(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: queen.color,
        ),
        
        Text(
          queen.breed,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: queen.isAlive ? AppColors.text : AppColors.text.withAlpha(60),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${queen.origin} - ${queen.birthDate.year}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.text.withAlpha(60),
              ),
        )
      ],
    );
  }

  Widget _buildHiveLabel(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppVectors.apiary,
          width: 24,
          height: 24,
          colorFilter: hive == null
              ? const ColorFilter.mode(
                  Color.fromARGB(60, 0, 0, 0), BlendMode.srcIn)
              : null,
        ),
        const SizedBox(width: 5),
        Text(
          hive?.type ?? 'no_hive'.tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: hive == null
                    ? AppColors.text.withAlpha(60)
                    : AppColors.text,
              ),
        )
      ],
    );
  }
}