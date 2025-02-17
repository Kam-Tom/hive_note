import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiaryTile extends StatelessWidget {
  final Apiary apiary;
  final int hiveCount;
  final void Function(Apiary apiary) onPressed;
  final void Function(Apiary apiary) onDismissed;
  final Future<bool?> Function(Apiary apiary) confirmDismiss;

  const ApiaryTile({
    super.key,
    required this.apiary,
    required this.hiveCount,
    required this.onPressed,
    required this.onDismissed,
    required this.confirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    const double squareSize = 10.0;
    const int maxHivesToShow = 36;

    final List<Widget> hiveWidgets =
        _buildHiveWidgets(context, squareSize, maxHivesToShow);

    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => confirmDismiss(apiary),
      onDismissed: (_) => onDismissed(apiary),
      background: Container(color: AppColors.failure),
      key: ValueKey(apiary),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => onPressed(apiary),
          style: ElevatedButton.styleFrom(
            backgroundColor: apiary.isActive 
                ? apiary.color 
                : apiary.color.withOpacity(0.2),
            foregroundColor: AppColors.white,
            elevation: apiary.isActive ? 3 : 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  _buildApiaryIconAndLabel(context),
                  Expanded(
                    child: _buildHives(context, hiveWidgets),
                  ),
                  const Icon(Icons.drag_indicator)
                ],
              ),
              if (!apiary.isActive)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'inactive_status'.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHiveWidgets(
      BuildContext context, double squareSize, int maxHivesToShow) {
    final List<Widget> hives = <Widget>[];
    final count = hiveCount;
    final int visibleHives = min(count, maxHivesToShow);

    for (int i = 0; i < visibleHives; i++) {
      hives.add(
        Container(
          width: squareSize,
          height: squareSize,
          color: Colors.white.withAlpha(170),
        ),
      );
    }

    if (count > maxHivesToShow) {
      hives.add(
        Container(
          color: AppColors.white.withAlpha(170),
          alignment: Alignment.center,
          child: Text(
            '+${count - maxHivesToShow}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return hives;
  }

  Widget _buildApiaryIconAndLabel(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppVectors.beehive,
            width: 40,
          ),
          Text(
            apiary.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHives(BuildContext context, List<Widget> hives) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: hives,
    );
  }
}
