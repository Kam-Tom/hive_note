import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class Failure extends StatelessWidget {
  const Failure({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.failure,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              "something_went_wrong".tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.failure,
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              "please_try_again_later".tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.failure,
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.failure,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text("back".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
