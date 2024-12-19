import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/settings/inspection_settings/presentation/inspection_settings_page.dart';
import 'package:hive_note/settings/preferences/presentation/preferences_page.dart';
import 'package:hive_note/settings/bloc/bottom_navigation_cubit.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(initialIndex: 0),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Builder(
              builder: (context) {
                switch (state) {
                  case 0:
                    return const PreferencesPage();
                  case 1:
                    return const InspectionSettingsPage();
                  default:
                    return Container(color: Colors.red,);
                }
              },
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: (index) => context.read<BottomNavigationCubit>().changeTab(index),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.room_preferences), 
                  label: 'preferences'.tr()
                ),
                NavigationDestination(
                  icon: const Icon(Icons.edit), 
                  label: 'inspections'.tr()
                ),
              ],
              backgroundColor: AppColors.primary,
              indicatorColor: AppColors.primaryLight,
              surfaceTintColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}