import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/navigation/models/hive.dart';

class InspectionCard extends StatelessWidget {
  final Hive hive;
  final void Function(Hive hive) onPressed;

  const InspectionCard({
    super.key, 
    required this.hive,
    required this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    const double squareSize = 10.0; 
    const int maxHivesToShow = 39;  

    final List<Widget> hiveWidgets = _buildHiveWidgets(context, squareSize, maxHivesToShow);

    return Container(
      width: 300,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () => onPressed(hive),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Container(
          child: Row(
            children: [
              _buildHiveIconAndLabel(context),
              Expanded(
                child: _buildHiveWrap(context, hiveWidgets),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHiveWidgets(BuildContext context, double squareSize, int maxHivesToShow) {
    final List<Widget> hives = <Widget>[];
    final int visibleHives = min(hive.count, maxHivesToShow);

    for (int i = 0; i < visibleHives; i++) {
      hives.add(
        Container(
          width: squareSize,
          height: squareSize,
          color: Colors.white.withAlpha(170),
        ),
      );
    }

    if (hive.count > maxHivesToShow) {
      hives.add(
        Container(  
          color: AppColors.white.withAlpha(170),
          margin: const EdgeInsets.only(right: 12.0),
          alignment: Alignment.center,
          child: Text(
            '+${hive.count - maxHivesToShow}',
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

  Widget _buildHiveIconAndLabel(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppVectors.beehive,
            width: 40,
          ),
          Text(
            hive.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHiveWrap(BuildContext context, List<Widget> hives) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: hives,
    );
  }
}
