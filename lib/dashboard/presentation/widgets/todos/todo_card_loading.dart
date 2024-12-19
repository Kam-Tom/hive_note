import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class TodoCardLoading extends StatelessWidget {
  const TodoCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    return Center(

      child: Container(
        width: width,
        height: 200,
        decoration: _buildBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.secondary,),
            const SizedBox(height: 20),
            Text(
              "loading".tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ],
        )
      ),

    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: AppColors.primaryLight,
      border: Border.all(
        color: const Color.fromARGB(125, 255, 255, 255),
        width: 5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}