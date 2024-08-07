import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class CustomAppFooter extends BottomAppBar {
  CustomAppFooter({super.key})
      : super(
          color : AppColors.primary,
          height: 40.0,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Container(

            decoration: const ShapeDecoration(
              color:AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
              ),
            ),
          ),
        );
}