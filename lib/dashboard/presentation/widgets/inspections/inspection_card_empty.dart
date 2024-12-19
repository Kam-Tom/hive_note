import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class InspectionCardEmpty extends StatelessWidget {
  final void Function() onPressed;

  const InspectionCardEmpty({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
   return Container(
      width: 300,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppVectors.beehive,
              width: 50,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "no_apiaries".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "tap_to_add_apiary".tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}